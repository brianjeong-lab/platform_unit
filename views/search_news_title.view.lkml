view: search_news_title {
  derived_table: {
    sql:
        SELECT DISTINCT(D_TITLE) AS TITLE, S_NAME, D_URL, DOCID
        FROM `kb-daas-dev.master_200729.keyword_bank`
        WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                        FROM `kb-daas-dev.master_200729.keyword_bank_result` R, UNNEST(R.KPE) AS RK
                        WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                                      FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
                                      WHERE K.keyword = {% parameter bank_name %}
                                      AND CHANNEL = {% parameter channel_name %}
                                      AND DATE(CRAWLSTAMP) = {% parameter search_date %})
                        AND DATE(CRAWLSTAMP) = {% parameter search_date %}
                        AND RK.keyword = {% parameter search_another_keyword %})
       ;;
  }

  filter: bank_name {
    type: string
  }

  filter: channel_name {
    type: string
  }

  filter: search_date {
    type: string
  }

  filter: search_another_keyword {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: TITLE {
    type: string
    sql: ${TABLE}.TITLE ;;
  }

  dimension: S_NAME {
    type: string
    sql: ${TABLE}.S_NAME ;;
  }

  dimension: D_URL {
    type: string
    sql: ${TABLE}.D_URL ;;
    link: {
      label: "원본문서 브라우져로 연결"
      url: "{{ value }}"
    }
  }

  dimension: DOCID {
    type: string
    sql: ${TABLE}.DOCID ;;
  }

  set: detail {
    fields: [TITLE]
  }
}

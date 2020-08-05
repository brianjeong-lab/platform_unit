view: search_original_content {
  derived_table: {
    sql: SELECT DOCID, D_TITLE AS TITLE, D_CONTENT AS CONTENT
        FROM `kb-daas-dev.master_200729.keyword_bank`
        WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                        FROM `kb-daas-dev.master_200729.keyword_bank_result` R, UNNEST(R.KPE) AS RK
                        WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                                      FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
                                      WHERE K.keyword = {% parameter search_keyword %}
                                      AND CHANNEL = {% parameter channel_name %}
                                      AND DATE(CRAWLSTAMP) = {% parameter search_date %})
                        AND DATE(CRAWLSTAMP) = {% parameter search_date %}
                        AND RK.keyword = {% parameter search_another_keyword %})
       ;;
  }

  filter: search_keyword {
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

  measure: cnt_keyword {
    type:sum
    sql:coalesce(${TABLE}.CNT) ;;
  }

  dimension: CONTENT {
    type: string
    sql: ${TABLE}.CONTENT ;;
  }

  dimension: TITLE {
    type: string
    sql: ${TABLE}.TITLE ;;
  }

  dimension: DOCID {
    type: string
    sql: ${TABLE}.DOCID ;;
  }

  set: detail {
    fields: [DOCID]
  }
}

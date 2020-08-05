view: keyword_word_cloud {
  derived_table: {
    sql: SELECT COUNT(*) AS CNT, RK.keyword AS KEYWORD
      FROM `kb-daas-dev.master_200729.keyword_bank_result` R, UNNEST(R.KPE) AS RK
      WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                    FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
                    WHERE K.keyword = {% parameter search_keyword %}
                    AND CHANNEL = {% parameter channel_name %}
                    AND DATE(CRAWLSTAMP) = {% parameter search_date %})
      AND DATE(CRAWLSTAMP) = {% parameter search_date %}
      AND KEYWORD != {% parameter search_keyword %}
      GROUP BY KEYWORD
      ORDER BY CNT DESC
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

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: cnt_keyword {
    type:sum
    sql:coalesce(${TABLE}.CNT) ;;
  }

  dimension: cnt {
    type: number
    sql: ${TABLE}.CNT ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.KEYWORD ;;
  }

  set: detail {
    fields: [cnt, keyword]
  }
}

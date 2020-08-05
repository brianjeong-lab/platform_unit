view: total_doc_cnt {
  derived_table: {
    sql: SELECT
        SUM(CNT_DOC) AS TOTAL_CNT_DOC,
        SUM(CNT_RESULT_DOC) AS TOTAL_RESULT_DOC,
        SUM(CNT_RESULT_KEYWORD) AS TOTAL_CNT_RESULT_KEYWORD,
        SUM(CNT_RESULT_UNIQUE_KEYWORD) AS TOTAL_CNT_RESULT_UNIQUE_KEYWORD
      FROM `kb-daas-dev.mart_200729.aggregation_daily_3`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: total_cnt_doc {
    type: number
    sql: ${TABLE}.TOTAL_CNT_DOC ;;
  }

  dimension: total_result_doc {
    type: number
    sql: ${TABLE}.TOTAL_RESULT_DOC ;;
  }

  dimension: total_cnt_result_keyword {
    type: number
    sql: ${TABLE}.TOTAL_CNT_RESULT_KEYWORD ;;
  }

  dimension: total_cnt_result_unique_keyword {
    type: number
    sql: ${TABLE}.TOTAL_CNT_RESULT_UNIQUE_KEYWORD ;;
  }

  set: detail {
    fields: [total_cnt_doc, total_result_doc, total_cnt_result_keyword, total_cnt_result_unique_keyword]
  }
}

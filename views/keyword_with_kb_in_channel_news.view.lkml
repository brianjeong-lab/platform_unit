view: keyword_with_kb_in_channel_news {
  derived_table: {
    sql: SELECT COUNT(*) AS CNT, RK.keyword AS KEYWORD
      FROM `kb-daas-dev.master_200729.keyword_bank_result` R, UNNEST(R.KPE) AS RK
      WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                    FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
                    WHERE (K.keyword = "국민은행" OR K.keyword = "KB국민은행")
                    AND CHANNEL = "뉴스"
                    AND DATE(CRAWLSTAMP) = "2020-06-01")
      AND DATE(CRAWLSTAMP) = "2020-06-01"
      AND KEYWORD != "국민은행"
      AND KEYWORD != "KB국민은행"
      GROUP BY KEYWORD
      ORDER BY CNT DESC
       ;;
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

view: ratio_bank_content {
  derived_table: {
    sql:
SELECT COUNT(*) AS CNT, "국민은행" AS BANK
FROM `kb-daas-dev.master_200729.keyword_bank`
WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
              FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
              WHERE (K.keyword = "국민은행" OR K.keyword = "KB국민은행")
              AND CHANNEL = {% parameter channel_name %}
              AND DATE(CRAWLSTAMP) = {% parameter search_date %})
AND DATE(D_CRAWLSTAMP) = {% parameter search_date %}

UNION ALL

SELECT COUNT(*) AS CNT, "신한은행" AS BANK
FROM `kb-daas-dev.master_200729.keyword_bank`
WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
              FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
              WHERE K.keyword = "신한은행"
              AND CHANNEL = {% parameter channel_name %}
              AND DATE(CRAWLSTAMP) = {% parameter search_date %})
AND DATE(D_CRAWLSTAMP) = {% parameter search_date %}

UNION ALL

SELECT COUNT(*) AS CNT, "우리은행" AS BANK
FROM `kb-daas-dev.master_200729.keyword_bank`
WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
              FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
              WHERE K.keyword = "우리은행"
              AND CHANNEL = {% parameter channel_name %}
              AND DATE(CRAWLSTAMP) = {% parameter search_date %})
AND DATE(D_CRAWLSTAMP) = {% parameter search_date %}

UNION ALL

SELECT COUNT(*) AS CNT, "하나은행" AS BANK
FROM `kb-daas-dev.master_200729.keyword_bank`
WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
              FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
              WHERE K.keyword = "하나은행"
              AND CHANNEL = {% parameter channel_name %}
              AND DATE(CRAWLSTAMP) = {% parameter search_date %})
AND DATE(D_CRAWLSTAMP) = {% parameter search_date %}

UNION ALL

SELECT COUNT(*) AS CNT, "농협은행" AS BANK
FROM `kb-daas-dev.master_200729.keyword_bank`
WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
              FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
              WHERE K.keyword = "농협은행"
              AND CHANNEL = {% parameter channel_name %}
              AND DATE(CRAWLSTAMP) = {% parameter search_date %})
AND DATE(D_CRAWLSTAMP) = {% parameter search_date %}
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

  measure: measure_cnt {
    type:sum
    sql:coalesce(${TABLE}.CNT) ;;
  }

  dimension: CNT {
    type: string
    sql: ${TABLE}.CNT ;;
  }

  dimension: BANK {
    type: string
    sql: ${TABLE}.BANK ;;
  }

  set: detail {
    fields: [CNT]
  }
}

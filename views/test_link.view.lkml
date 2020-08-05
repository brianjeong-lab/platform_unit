view: test_link {
  derived_table: {
    sql:
      WITH tmp AS
        (
        SELECT {% parameter search_date %} AS filter_date,
               {% parameter search_keyword %} AS filter_keyword,
               {% parameter channel_name %} AS filter_channel
        )
      SELECT * FROM tmp
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

  dimension: filter_date {
    type: string
    sql: ${TABLE}.filter_date ;;
  }

  dimension: filter_keyword {
    type: string
    sql: ${TABLE}.filter_keyword ;;
  }

  dimension: filter_channel {
    type: string
    sql: ${TABLE}.filter_channel ;;
  }

  dimension: search {
    sql:
      SELECT DOCID, D_TITLE AS TITLE, D_CONTENT AS CONTENT
      FROM `kb-daas-dev.master_200729.keyword_bank`
      WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                      FROM `kb-daas-dev.master_200729.keyword_bank_result` R, UNNEST(R.KPE) AS RK
                      WHERE DOCID IN (SELECT DISTINCT(DOCID) AS DOCID
                                    FROM `kb-daas-dev.master_200729.keyword_bank_result` T, UNNEST(T.KPE) AS K
                                    WHERE (K.keyword = "국민은행" OR K.keyword = "KB국민은행")
                                    AND CHANNEL = "뉴스"
                                    AND DATE(CRAWLSTAMP) = "2020-06-01")
                      AND DATE(CRAWLSTAMP) = "2020-06-01"
                      AND RK.keyword = "지난해")
    ;;
    html: <a href="/explore/model/explore_name?fields=view_name.field_name1,view_name.field_name2,view_name.field_name3&f[view_name.filter_1]={{ value }}&pivots=view.field_2">{{ value }}</a> ;;
  }

  dimension: name {
    sql: ${name};;
    html: <a href="/explore/model/explore_name?fields=view_name.set_name*&f[view_name.filter_1]={{ value }}&pivots=view_name.field_2">{{ value }}</a> ;;
  }

  dimension: link {
    type: string
    sql: ${TABLE}.filter_keyword ;;
    link: {
      label: "Search Link"
      url: "www.naver.com"
    }
  }

  set: detail {
    fields: [filter_date]
  }
}

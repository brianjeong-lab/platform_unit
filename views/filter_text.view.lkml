view: filter_text {
  derived_table: {
    sql:
      WITH tmp AS
        (
        SELECT {% parameter search_date %} AS filter_date,
               {% parameter search_bank %} AS filter_bank,
               {% parameter channel_name %} AS filter_channel,
               {% parameter search_keyword %} AS filter_another_keyword
        )
      SELECT * FROM tmp
       ;;
  }

  filter: search_bank {
    type: string
  }

  filter: channel_name {
    type: string
  }

  filter: search_date {
    type: string
  }

  filter: search_keyword {
    type: string
  }

  dimension: filter_date {
    type: string
    sql: ${TABLE}.filter_date ;;
  }

  dimension: filter_bank {
    type: string
    sql: ${TABLE}.filter_bank ;;
  }

  dimension: filter_another_keyword {
    type: string
    sql: ${TABLE}.filter_another_keyword ;;
  }

  dimension: filter_channel {
    type: string
    sql: ${TABLE}.filter_channel ;;
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

view: keyword_corona_result {
  sql_table_name: `master_200729.keyword_corona_result`
    ;;

  dimension: channel {
    type: string
    sql: ${TABLE}.CHANNEL ;;
  }

  dimension_group: crawlstamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CRAWLSTAMP ;;
  }

  dimension: d2_c {
    hidden: yes
    sql: ${TABLE}.D2C ;;
  }

  dimension: docid {
    type: number
    value_format_name: id
    sql: ${TABLE}.DOCID ;;
  }

  dimension: kpe {
    hidden: yes
    sql: ${TABLE}.KPE ;;
  }

  dimension: kse {
    hidden: yes
    sql: ${TABLE}.KSE ;;
  }

  dimension_group: procstamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.PROCSTAMP ;;
  }

  dimension: response {
    hidden: yes
    sql: ${TABLE}.RESPONSE ;;
  }

  dimension: s_name {
    type: string
    sql: ${TABLE}.S_NAME ;;
  }

  dimension: sb_name {
    type: string
    sql: ${TABLE}.SB_NAME ;;
  }

  dimension: ss {
    type: string
    sql: ${TABLE}.SS ;;
  }

  dimension_group: writestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.WRITESTAMP ;;
  }

  measure: count {
    type: count
    drill_fields: [s_name, sb_name]
  }
}

view: keyword_corona_result__kpe {
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}

view: keyword_corona_result__d2_c {
  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}

view: keyword_corona_result__kse {
  dimension: idx {
    type: number
    sql: ${TABLE}.idx ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}

view: keyword_corona_result__response {
  dimension: err_msg {
    type: string
    sql: ${TABLE}.err_msg ;;
  }

  dimension: proc_time {
    type: number
    sql: ${TABLE}.proc_time ;;
  }

  dimension: status_code {
    type: number
    sql: ${TABLE}.status_code ;;
  }
}

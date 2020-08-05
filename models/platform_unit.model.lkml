connection: "kb-daas-dev"

# include all the views
include: "/views/**/*.view"

datagroup: platform_unit_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: platform_unit_default_datagroup

explore: keyword_with_kb_in_channel_news {}

explore: total_doc_cnt {}

explore: wc_with_filter {}

explore: wc_with_filter_limit100 {}

explore: keyword_word_cloud{}

explore: filter_text {}

explore: keyword_bank {}

explore: test_link {}

explore: search_original_content {}

explore: search_news_title {}

explore: ratio_bank_content {}

explore: keyword_bank_result {
  join: keyword_bank_result__kpe {
    view_label: "Keyword Bank Result: Kpe"
    sql: LEFT JOIN UNNEST(${keyword_bank_result.kpe}) as keyword_bank_result__kpe ;;
    relationship: one_to_many
  }

  join: keyword_bank_result__d2_c {
    view_label: "Keyword Bank Result: D2c"
    sql: LEFT JOIN UNNEST(${keyword_bank_result.d2_c}) as keyword_bank_result__d2_c ;;
    relationship: one_to_many
  }

  join: keyword_bank_result__kse {
    view_label: "Keyword Bank Result: Kse"
    sql: LEFT JOIN UNNEST(${keyword_bank_result.kse}) as keyword_bank_result__kse ;;
    relationship: one_to_many
  }

  join: keyword_bank_result__response {
    view_label: "Keyword Bank Result: Response"
    sql: LEFT JOIN UNNEST([${keyword_bank_result.response}]) as keyword_bank_result__response ;;
    relationship: one_to_one
  }
}

explore: keyword_corona {}

explore: keyword_corona_result {
  join: keyword_corona_result__kpe {
    view_label: "Keyword Corona Result: Kpe"
    sql: LEFT JOIN UNNEST(${keyword_corona_result.kpe}) as keyword_corona_result__kpe ;;
    relationship: one_to_many
  }

  join: keyword_corona_result__d2_c {
    view_label: "Keyword Corona Result: D2c"
    sql: LEFT JOIN UNNEST(${keyword_corona_result.d2_c}) as keyword_corona_result__d2_c ;;
    relationship: one_to_many
  }

  join: keyword_corona_result__kse {
    view_label: "Keyword Corona Result: Kse"
    sql: LEFT JOIN UNNEST(${keyword_corona_result.kse}) as keyword_corona_result__kse ;;
    relationship: one_to_many
  }

  join: keyword_corona_result__response {
    view_label: "Keyword Corona Result: Response"
    sql: LEFT JOIN UNNEST([${keyword_corona_result.response}]) as keyword_corona_result__response ;;
    relationship: one_to_one
  }

}

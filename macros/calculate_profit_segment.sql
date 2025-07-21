{% macro calculate_profit_segment(profit_column) %}
  case 
    when {{ profit_column }} >= 20 then 'High_Profit'
    when {{ profit_column }} >= 5 then 'Medium_Profit'
    when {{ profit_column }} > 0 then 'Low_Profit'
    else 'No_Profit'
  end
{% endmacro %}
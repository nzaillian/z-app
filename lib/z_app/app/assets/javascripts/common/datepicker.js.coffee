$(document).bind('ready page:load page:restore', ->
  $(".datepicker-input").each( ->
    input = $(this)
    wrap = $(this).parents(".datepicker-input-wrap").first()
    date_select = wrap.find(".datepicker-field-wrap")
    
    input.datepicker({
      beforeShow: (input, inst) ->
        inst.dpDiv.addClass("datepicker-input-datepicker")
      onSelect: (date_str, inst) ->
        date = new Date(date_str)
        year = date.getFullYear().toString()
        month = (date.getMonth() + 1).toString()
        day = date.getDate().toString()
        
        year_select = date_select.find("select").eq(0)
        month_select = date_select.find("select").eq(1)
        day_select = date_select.find("select").eq(2)

        year_select.find("option[selected]").removeAttr("selected")
        month_select.find("option[selected]").removeAttr("selected")
        day_select.find("option[selected]").removeAttr("selected")

        year_select.find("option[value='#{year}']").attr("selected", "selected")
        month_select.find("option[value='#{month}']").attr("selected", "selected")
        day_select.find("option[value='#{day}']").attr("selected", "selected")
    })
  )
)
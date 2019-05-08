shinyServer(function(input, output){

    date_range <- reactive({
        c(input$daterange[1], input$daterange[2])
    })

    # filter by date range
    filt_ce <- reactive({
        centralEntities %>% 
            filter( logged_on >= date_range()[1],
                    logged_on <= date_range()[2])
    })

    filt_me <- reactive({
        metaEntities %>% 
            filter( logged_on >= date_range()[1],
                    logged_on <= date_range()[2])
    })

    observeEvent(input$date_reset, {
        reset("daterange")
    })

})
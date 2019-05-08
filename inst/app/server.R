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

    # plotting entity creation/initialization
    output$entity_creation_plot <- renderPlotly({
        # combine into single tidydf
        plot1 <- filt_ce() %>% 
            mutate(entity_type = "Central Entity") %>% 
            rename(id = entity_id) %>% 
            bind_rows(filt_me() %>% 
                mutate(entity_type = "Secondary Entity") %>% 
                rename(id = meta_id)) %>%
            mutate(logged_date = as.Date(logged_on)) %>% 
            ggplot(aes(created_date, color = entity_type)) + 
            stat_bin(binwidth = 7, geom = "line") + 
            stat_bin(binwidth = 7, geom = "point") + 
            facet_grid(entity_type~., scales = "free") + 
            ylab("Count") + 
            scale_x_date("Logged Date (bin by week)",
                date_labels="%b %d %Y") + 
            scale_color_brewer("Type", palette = "Dark2", guide = F) +
            theme_bw() + 
            teme(axis.text.x = element_text(hjust = 1, angle = 0, size = 9))
        plot1 %>% ggplotly()
    })
})
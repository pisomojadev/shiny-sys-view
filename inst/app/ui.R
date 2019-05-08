dashboardPage(
    dashboardHeader(title = "System Entity Monitor"),
    dashboardSideBar(collapsed = T),
    dashboardBody(
        fluidRow(
            useShinyjs(),
            box(title = "System Enitity Monitor",
                p("Entity Descriptions",
                    br(),
                    hr(),
                    a(href="maito:nbdavis.stl@gmail.com", "Report Issues/Request Enhancements")
                ),
                dateRangeInput("daterange", "Choose a timeframe",
                    start=Sys.Date()-90, end=NULL),
                actionButton("date_reset", "Reset Dates")
            ),
            box(title = "Entity Creation"), 
                plotlyOutput("entity_creation_plot")
        )
    )
)
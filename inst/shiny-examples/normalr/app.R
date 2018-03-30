
library(shiny)
library(normalr)
library(MASS)
library(parallel)
library(purrr)
library(magrittr)
library(rlang)

ui <- fluidPage(
  titlePanel("normalr R package"),
  sidebarLayout(
    sidebarPanel(
      checkboxInput('testData', 'Use test Dataset', FALSE),
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv',
                         'text/comma-separated-values,text/plain',
                         '.csv')),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      downloadButton('downloadData', 'Download'),
      h3("Latest Update:"),
      h4("2018-03-30"),
      h3("Contact email:"),
      a("k.chang@auckland.ac.nz",
        href= "mailto:k.chang@auckland.ac.nz")
    ),

    mainPanel(
      h3("Lambdas:"),
      tableOutput('lambda'),
      h3("Input Data:"),
      tabsetPanel(
        tabPanel("Original Data", tableOutput('data')),
        tabPanel("Transformed Data", tableOutput('newdata')))
    )

  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {


  oldData <- reactive({

    if(input$testData) return(testData)

    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)

    read.csv(inFile$datapath, header=input$header, sep=input$sep)
  })

  output$data <-renderTable({
    oldData()

  })

  lambda <-
    reactive({
      getLambda(req(oldData()))
    })


  output$lambda <-renderTable({
    lambda <- req(lambda())

    lambda <- t(as.data.frame(lambda))

    colnames(lambda) <- names(oldData())

    lambda
  })

  newData <- reactive( {

    normaliseData(oldData(), lambda())
  })

  output$newdata <-renderTable({

    newData()
  })

  output$downloadData <- downloadHandler(
    filename = function() {
      paste('newData.csv', sep='')
    },
    content = function(file) {
      write.csv(newData(), file, row.names = FALSE)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)


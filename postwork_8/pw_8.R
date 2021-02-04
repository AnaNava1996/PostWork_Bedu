# Postwork 8
# Ejecuta el código momios.R

# Almacena los gráficos resultantes en formato png

# Crea un dashboard donde se muestren los resultados con 4 pestañas:

# 1)    
# Una con las gráficas de barras, donde en el eje de las x se muestren 
# los goles de local y visitante con un menu de selección, 
# con una geometria de tipo barras además de hacer un facet_wrap 
# con el equipo visitante

# 2)
# Realiza una pestaña donde agregues las imágenes de las gráficas del postwork 3

# 3)
# En otra pestaña coloca el data table del fichero match.data.csv

# 4)
# Por último en otra pestaña agrega las imágenes de las gráficas de los factores de ganancia mínimo y máximo

library(class)
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)

library(shiny)
#install.packages("shinydashboard")
library(shinydashboard)
matches <- read.csv("match.data.csv") %>%
    mutate(local=home.score,visitante=away.score)#%>%
    #select("home.team","home.score","away.team","away.score")
# Define UI for application that draws a histogram
ui <- pageWithSidebar(
    headerPanel("Postwork 8"),
    sidebarPanel(
        selectInput('rowName', 'Seleccione equipo local:', distinct_at(matches,vars(home.team)))
    ),
    mainPanel(
        
        
        #Agregando pestannas
        tabsetPanel(
            tabPanel("Plots",                   # Pestanna 1
                     h3(textOutput("rowName")), 
                     plotOutput("output_plot"), 
            ),
            
            tabPanel("PW-3",                # Pestanna 2
                     img( src = "goles_local.png", 
                          height = 450
                     ),
                     img( src = "goles_visit.png",
                          height = 450
                     ),
                     img( src = "goles_equipos.png",
                          height = 450
                     )
            ), 
            
            tabPanel("Data Table", dataTableOutput("data_table")),   # Pestanna 3
            tabPanel("F.G.",                # Pestanna 4
                     img( src = "apuestas.png"#, 
                          #height = 450, width = 450
                     )
            )     # Pestanna 4
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    #reactive(dat4 <- filter(matches,home.team==input$rowName))
    #Gráficas                       <----------
    output$output_plot <- renderPlot( 
        ggplot(pivot_longer(filter(matches,home.team==input$rowName),c(`local`, `visitante`), names_to = "team", values_to = "score"),aes(x=team,fill=team))
        +geom_bar() 
        + facet_wrap(~ away.team)
        + labs(title = str_c("Local: ", input$rowName," VS visitante:"))
            
        )
    
    #Agregando el data table       <----------
    output$data_table <- renderDataTable({mtcars}, 
                                         options = list(aLengthMenu = c(5,25,50),
                                                        iDisplayLength = 5))
}

# Run the application 
shinyApp(ui = ui, server = server)

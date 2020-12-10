# may_need_to_install_library_first
# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("readxl")
# installed.packages("dplyr")
# installed.packages("ggplot2")
# installed.packages("leaflet")
# installed.packages("leaflet.extras")
# installed.packages("treemap")
# installed.packages("plotly")
# installed.packages("RColorBrewer")
# installed.packages("wordcloud")
# installed.packages("tm")
# installed.packages("slam")
# installed.packages("forecast")
# installed.packages("tseries")



library(shiny)
library(shinydashboard)
library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(leaflet)
library(leaflet.extras)
library(treemap)
library(plotly)
library(RColorBrewer)
library(wordcloud)
library(tm)
library(slam)
library(forecast)
library(tseries)
library(ggmap)
library(tidyverse)


##need to change path
setwd("C:/Users/monol/OneDrive - Singapore Management University/Python and R/R/R_Group_Project/R_Shiny_Final")

##dataset
weather=read.csv("weather.csv") #whole weather data
sing_weather=read.csv("sing_weather.csv")
map=read.csv("map.csv") 
F_D = read.csv("Full_Climate_Data.csv") #hypothesis
S_D = read.csv("Singapore_Aggregate_Data.csv")
X8c <- read_excel("8c.xlsx") # Arima_rain
X11c <- read_excel("11c.xlsx") # Arima_temp
X12 <- read_excel("12.xlsx") # Arima_wind
sg_yearly=read.csv("3. Singapore Yearly Data.csv",sep=",") # corr
sg_monthly=read.csv("2. Singapore Monthly Data.csv",sep=",")
sg_decadal=read.csv("5. Singapore Decadal Data.csv",sep=",")
register_google(key = "AIzaSyDwi9DzzbTp9-VJFA4t6CwhIRdf5lNjAos", write = TRUE)
df = read.csv("Full_Climate_Data.csv")




stations=unique(weather$station)
level=unique(map$level)
years=unique(weather$year)
months=unique(weather$Month)
df = subset(df,select = -c(3,4,6,7,8,10,11,13,14))




######################################################### Shiny STARTS FROM HERE
ui <- dashboardPage(skin = 'blue',
                    dashboardHeader(title = 'Singapore Weather', titleWidth = 250),
                    dashboardSidebar(width = 250,
                                     sidebarMenu(id = 'sbm',
                                                 menuItem('Introduction', tabName = 'Introduction',
                                                          icon = icon("thumbs-up",lib="glyphicon")),
                                                 menuItem('Inferential', tabName = 'Inferential',
                                                          icon = icon("tint",lib="glyphicon")),
                                                 menuItem('Descriptive', tabName = 'Descriptive',
                                                          icon = icon("certificate",lib="glyphicon")),
                                                 menuItem('Forecasting', tabName = 'Forecasting',
                                                          icon = icon("cloud",lib="glyphicon"))
                                                 # menuItem('CI', tabName = 'CI', icon = NULL)
                                     )
                    ),
                    
                    ### INTRODUCTION
                    
                    dashboardBody(
                        tabItems(
                            tabItem(tabName = 'Introduction',
                                    fluidPage(
                                        titlePanel("Singapore Weather"),
                                        fluidRow(
                                          column(width = 12,
                                                 box(width = 12,
                                                     helpText("The world's climate appears to be changing and this is causing
                                                     disruption with negative economic impact.
                                                     Without going into the reasons for such change,
                                                     our objective is to examine whether that change is discernible
                                                     by examining climate metrics such as rainfall, temperature and wind speed. 
                                                     For example, we would like to examine for indications on whether it
                                                     has been getting drier and warmer over Singapore.")
                                                 ),
                                                 box(
                                                   width = 12,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   plotOutput('heatmap', height = 500)
                                                 )
                                          )
                                        )
                                      )
                                    ), ###end of introduction
                            
                            
                            ### DESCRIPTION
                            tabItem(tabName = 'Descriptive',
                                    fluidPage(
                                        titlePanel("Descriptive Analysis"),
                                        fluidRow(
                                            column(width = 12,
                                                   box(width = 6,
                                                       radioButtons('xcol',label = tags$strong('Factors: select factors of weather'),
                                                                    choices = c('rain' = 'rain',
                                                                                'temp' = 'temp',
                                                                                'wind' = 'wind'),
                                                                    inline = TRUE)
                                                   ),
                                                   box(width = 6,
                                                     selectInput("region2", "Region: select the region to display yearly trend",choices = stations)
                                                     
                                                   )
                                                   ) 
                                        ),#end of input 
                                        
                                        fluidRow(
                                            column(width = 12,
                                                   box(
                                                     width = 6,height = 350,solidHeader = TRUE,
                                                     collapsible = FALSE,collapsed = FALSE,
                                                     plotOutput('singyear', height = 300)
                                                   ),
                                                   box(
                                                       width = 6, height = 350,solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('descriptiveAnalysis', height = 300)
                                                   )
                                            )
                                        ), # end of plot
                                        
                                        fluidRow(
                                          column(width = 12,
                                                 box(width = 6,
                                                     sliderInput("years", "Year: select the year to compare through stations",
                                                                 min = 1980, max = 2020, value = 2020)
                                                     
                                                 )
                                          ) 
                                        ), #end of input 
                                        
                                        
                                        fluidRow(
                                          column(width = 12,
                                                 box(
                                                   width = 6,height = 350, solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   plotOutput('yearof', height = 300)
                                                 ),
                                                 box(
                                                   width = 6,height = 350, solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   plotOutput('corr', height = 300)
                                                 )
                                          )
                                        )
                                    )), # end of plot
                            
                            #end of tabname "Descriptive" 
                            

                                tabItem(tabName = 'Inferential',
                                        fluidPage(
                                          titlePanel("Inferential Analysis"),
                                          fluidRow(
                                            column(width = 12,
                                                   box(width = 12,
                                                      helpText("Analysis of Temp ")
                                                   ),
                                                   box(width = 6,height = 350,solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('temp_hist1', height = 300)
                                                   ),
                                                   box(width = 6,height = 350, solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('temp_hist2', height = 300)
                                                   ),
                                                   
                                                   box(width = 12,solidHeader = TRUE,collapsible = FALSE,collapsed = FALSE,
                                                       textOutput('temp_test1'),
                                                       textOutput('temp_test2'),
                                                       textOutput('temp_test3')
                                                   ),
                                                   
                                                   box(width = 12,
                                                       helpText("Analysis of Rain")
                                                   ),
                                                   box(width = 6,height = 350,solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('rain_hist1', height = 300)
                                                   ),
                                                   box(width = 6,height = 350, solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('rain_hist2', height = 300)
                                                   ),
                                                   box(width = 12,solidHeader = TRUE,collapsible = FALSE,collapsed = FALSE,
                                                       textOutput('rain_test1'),
                                                       textOutput('rain_test2'),
                                                       textOutput('rain_test3')
                                                   ),
                                                   
                                                   box(width = 12,
                                                       helpText("Analysis of Wind")
                                                   ),
                                                   box(width = 6,height = 350,solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('wind_hist1', height = 300)
                                                   ),
                                                   box(width = 6,height = 350, solidHeader = TRUE,
                                                       collapsible = FALSE,collapsed = FALSE,
                                                       plotOutput('wind_hist2', height = 300)
                                                   ),
                                                   
                                                   box(width = 12,solidHeader = TRUE,collapsible = FALSE,collapsed = FALSE,
                                                       textOutput('wind_test1'),
                                                       textOutput('wind_test2'),
                                                       textOutput('wind_test3')
                                                   )
                                                   ))
                                          
                                          )
                                        
                                        ),
                            
                            
                            ### Forecasting
                            tabItem(tabName = 'Forecasting',
                                    fluidPage(
                                      titlePanel("Forecasting Model"),
                                      fluidRow(
                                        column(width = 12,
                                               
                                               
                                               box(width = 12,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   "Arima Alanysis of Rain"
                                               ),
                                               
                                               box(width = 6,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   plotOutput('arima_rain11', height = 300)
                                               ),
                                               
                                               box(width = 6,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   textOutput('arima_rain1')
                                               ), #rain
                                               
                                               
                                               box(width = 12,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   "Arima Alanysis of Temp"
                                               ),
                                               
                                               box(width = 6,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   plotOutput('arima_temp33', height = 300)
                                               ),
                                               
                                               box(width = 6,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   textOutput('arima_temp3')
                                               ), #temp
                                               
                                               box(width = 12,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   "Arima Alanysis of Wind"
                                               ),
                                               
                                               box(width = 6,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   plotOutput('arima_wind11', height = 300)
                                               ),
                                               
                                               box(width = 6,height = 350,solidHeader = TRUE,
                                                   collapsible = FALSE,collapsed = FALSE,
                                                   textOutput('arima_wind1')
                                               )
                                               
                                               
                                        ))
                                      
                                    )
                                    
                            )#end of tabname "Forecasting"
                            
                                )))




##########################################################################################Server code starts here
                                
server <- function(input, output) {
    
    pal <- colorFactor(palette = c("red", "black", "blue",
                                   "red", "red", "black",
                                   "blue", "red", "black",
                                   "blue"),levels = level)
    
    fd_temp = df %>% drop_na(Mean_Temperature)
    fd_temp = aggregate(fd_temp$Mean_Temperature,
                        list(Station = fd_temp$Station, Year = fd_temp$Year, Lat = fd_temp$Lat..N., Long = fd_temp$Long...E.), mean)
    fd_temp = fd_temp %>% arrange(Station,Year)
    colnames(fd_temp)
    names(fd_temp)[5] = "Tempreture"
    colnames(fd_temp)
    
    fd_wind = df %>% drop_na(Mean.Wind.Speed..km.h.)
    fd_wind = aggregate(fd_wind$Mean.Wind.Speed..km.h., 
                        list(Station = fd_wind$Station, Year = fd_wind$Year,Lat = fd_wind$Lat..N., Long = fd_wind$Long...E.), mean)
    fd_wind= fd_wind %>% arrange(Station,Year)
    colnames(fd_wind)
    names(fd_wind)[5] = "Wind"
    colnames(fd_wind)
    
    fd_rain = df %>% drop_na(Daily.Rainfall.Total..mm.)
    fd_rain = aggregate(fd_rain$Daily.Rainfall.Total..mm.,
                        list(Station = fd_rain$Station, Year = fd_rain$Year,Lat = fd_rain$Lat..N., Long = fd_rain$Long...E.), sum)
    fd_rain= fd_rain %>% arrange(Station,Year)
    colnames(fd_rain)
    names(fd_rain)[5] = "Rain"
    colnames(fd_rain)
    
    
    write.csv(fd_rain, file = "Heatmap_rain.csv")
    write.csv(fd_wind, file = "Heatmap_wind.csv")
    write.csv(fd_temp, file = "Heatmap_temp.csv")
    df_temp = read.csv("Heatmap_temp.csv")
    df_wind = read.csv("Heatmap_wind.csv")
    df_rain = read.csv("Heatmap_rain.csv")
    df_temp = subset(df_temp, select = -1)
    df_temp_2020 = subset(df_temp, Year >= 2015)
    df_temp$Year = as.factor(df_temp$Year)
    mean.longitude = mean(df_temp_2020$Long)
    mean.latitude = mean(df_temp_2020$Lat)
    Singapore.map = get_map(location = c(mean.longitude, mean.latitude), zoom = 11, scale = 2)
    
    Singapore.map <- ggmap(Singapore.map, extent="device", legend="none")
    Singapore.map <- Singapore.map + stat_density2d(data=df_temp_2020,
                                                    aes(x=Long, y=Lat, fill=..level.., alpha=..level..), geom="polygon")
    Singapore.map <- Singapore.map + scale_fill_gradientn(colours=rev(brewer.pal(7, "Spectral")))
    Singapore.map <- Singapore.map + geom_point(data=df_temp_2020,
                                                aes(x=Long, y=Lat), fill="red", shape=21, alpha=0.8)
    Singapore.map <- Singapore.map + guides(size=FALSE, alpha = FALSE)
    Singapore.map <- Singapore.map + ggtitle("Heatmap Tempreture")
    
    
    

    output$map <- renderLeaflet({
            map %>%
            filter(`level` == input$region) %>%
            leaflet() %>%
            setView(lng = 103.8522, lat = 1.347510, zoom = 11) %>%
            addTiles() %>%
            addCircleMarkers(label = ~ station, lng= ~ lon, lat= ~ lat,
                             color = ~ pal(input$region), radius = 3, fillOpacity = 0.5) %>%
            addSearchGoogle() 
    })
    
    output$heatmap <- renderPlot({
      Singapore.map <- Singapore.map + facet_wrap(~Year)
      print(Singapore.map)
    })
    
    
####################################################end of introduction
    
    station_year=weather %>%
      group_by(station,year) %>%
      summarize(rain=sum(rain,na.rm = T),
                temp=mean(temp,na.rm = T),
                wind=mean(wind,na.rm = T))
    
    sing_year=sing_weather %>%
      group_by(year) %>%
      summarise(rain=sum(rain,na.rm = T),
                temp=mean(temp,na.rm = T),
                wind=mean(wind,na.rm = T))
    
    station=weather %>%
      group_by(station) %>%
      summarize(rain=sum(rain,na.rm = T)^10,
                temp=mean(temp,na.rm = T)^10,
                wind=mean(wind,na.rm = T)^10,
                lat=mean(lat),lon=mean(lon))
    
    # A.1 ANNUAL RAINFALL BY DECADE: 1980-89, 1990-99, 2000-09 AND 2010-19
    
    sg_rainfall_1980s=sg_yearly[1:10,2]
    sg_rainfall_1990s=sg_yearly[11:20,2]
    sg_rainfall_2000s=sg_yearly[21:30,2]
    sg_rainfall_2010s=sg_yearly[31:40,2]
    sg_rainfall_1980to2019=c(sg_rainfall_1980s,sg_rainfall_1990s,sg_rainfall_2000s,sg_rainfall_2010s)
    
    # C.1 WIND SPEEDS BY DECADE: 1980-89, 1990-99, 2000-09, 2010-19 
    
    sg_wind_1980s=sg_yearly[1:10,5]
    sg_wind_1990s=sg_yearly[11:20,5]
    sg_wind_2000s=sg_yearly[21:30,5]
    sg_wind_2010s=sg_yearly[31:40,5]
    sg_wind_1980to2019=c(sg_wind_1980s,sg_wind_1990s,sg_wind_2000s,sg_wind_2010s)
    sg_wind_1980to2019_mean=mean(sg_wind_1980to2019)
    
    
    
    ### graph
    output$descriptiveAnalysis <- renderPlot({
        analysis <- station_year %>%
          filter(station==input$region2) %>% 
          select(station,year, input$xcol)
        
        p <- ggplot(analysis, aes_string(y = input$xcol, x = analysis$year)) +
            geom_point() + stat_smooth(color="blue",fill="pink") + 
            labs(title = 'Weather of Each Station', subtitle = paste('by', input$xcol), 
                 x = 'year' , y = input$xcol,fill = input$xcol)
        return(p)
            
        })
    
    output$singyear <- renderPlot({
      
      p <- ggplot(sing_year, aes_string(y = input$xcol, x = sing_year$year)) +
        geom_point() + stat_smooth(color="blue",fill="pink") + 
        labs(title = 'Weather of Whole Singapore', subtitle = paste('by', input$xcol), 
             x = 'year' , y = input$xcol,fill = input$xcol)
      return(p)
      
    })
    
    output$yearof <- renderPlot({
      analysis <- station_year %>%
        filter(year==input$years) %>% 
        select(station,year, input$xcol)
      
      p <- ggplot(analysis, aes_string(y = input$xcol, x = analysis$station)) +
        geom_point() + stat_smooth(color="blue",fill="pink") + 
        labs(title = 'Weather of Each Year', subtitle = paste('by', input$xcol), 
             x = 'station',fill = input$xcol)
      return(p)
      
    })
    
    output$treemap <- renderPlot({
      
      p <- treemap(station,vSize = input$xcol, index = "station")
      return(p)
      
    })
    
    
    output$wordcloud <- renderPlot({
      q <- station %>% select(station,rain) %>% na.omit()
      pal=brewer.pal(8,"Dark2")[5:9]
      p=wordcloud(words = q$station,freq = q$rain,colors = pal,scale = c(2,0.3))
      
      
      return(p)
      
    })
    
    
    output$boxrain <- renderPlotly({
      
      p <- station_year %>% plot_ly(y=~rain, x=~year,type="box")
      
      return(p)
      
    })
    
    output$boxtemp <- renderPlotly({
      
      p <- station_year %>% plot_ly(y=~temp, x=~year,type="box")
      
      return(p)
      
    })
    
    output$boxwind <- renderPlotly({
      
      p <- station_year %>% plot_ly(y=~wind, x=~year,type="box")
      
      return(p)
      
    })
    
    output$corr <- renderPlot({
      
      p <- plot(sg_rainfall_1980to2019,sg_wind_1980to2019, col="black", pch=8, main="Windspeed vs. Rainfall",
                col.main="blue", cex.main=1, xlab="Rainfall (mm)", ylab="Windspeed (km/h")
      
      return(p)
      
    })
    
    
#################end of descriptive analysis
    
    
    ### hypothesis
    
    
    #temp
    
    F_T = S_D[,c(1,6)]
    F_T_O = na.omit(F_T)
    row.names(F_T_O) = NULL
    T1 = F_T_O[1:6955,]
    T2 = F_T_O[6956:13910,]
    
    output$temp_test1 <- renderText({
      temp_sha1=shapiro.test(T1$Average.of.Mean_Temperature[1:5000])
      paste("1. Normality Test Result(1982-2001): p-value = 3.275e-10")
      
    })
    
    output$temp_test2 <- renderText({
      temp_sha2=shapiro.test(T2$Average.of.Mean_Temperature[1:5000])
      paste("2. Normality Test Result(2001-2020): p-value = 3.477e-09")
      
    })
    
    output$temp_test3 <- renderText({
      temp_wil=wilcox.test(T1$Average.of.Mean_Temperature,T2$Average.of.Mean_Temperature,paired = TRUE,alternative = "two.sided")
      paste("3. Non-parametric Pair Test Result: p-value < 2.2e-16")
      
    })
    
    output$temp_hist1 <- renderPlot({
      p=hist(T1$Average.of.Mean_Temperature, breaks = 250, col = "purple", 
             main = "Distribution of Singapore Mean Tempreture 1982-2001", xlab = "Mean tempreture")
      return(p)
      
    })
    
    output$temp_hist2 <- renderPlot({
      p=hist(T2$Average.of.Mean_Temperature, breaks = 250, col = "purple",
             main = "Distribution of Singapore Mean Tempreture 2001-2020", xlab = "Mean tempreture")
      return(p)
      
    })
    
    
    #rain
    
    F_R = S_D[,c(1,2)]
    row.names(F_R) = NULL
    R1 = F_R[1:7320,]
    R2 = F_R[7321:14640,]
    
    output$rain_test1 <- renderText({
      temp_sha1=shapiro.test(R1$Average.of.Daily.Rainfall.Total..mm.[1:5000])
      paste("1. Normality Test Result(1982-2001): p-value < 2.2e-16")
      
    })
    
    output$rain_test2 <- renderText({
      temp_sha2=shapiro.test(R2$Average.of.Daily.Rainfall.Total..mm.[1:5000])
      paste("2. Normality Test Result(2001-2020): p-value < 2.2e-16")
      
    })
    
    output$rain_test3 <- renderText({
      temp_wil=wilcox.test(R1$Average.of.Daily.Rainfall.Total..mm.,R2$Average.of.Daily.Rainfall.Total..mm.,paired = TRUE,alternative = "two.sided")
      paste("3. Non-parametric Pair Test Result: p-value = 0.01039")
      
    })
    
    output$rain_hist1 <- renderPlot({
      p=hist(log(R1$Average.of.Daily.Rainfall.Total..mm.), breaks = 250, col = "purple",
             main = "Distribution of Singapore Log Mean Rainfall 1980-2000", xlab = "Log Mean Rainfall")
      return(p)
      
    })
    
    output$rain_hist2 <- renderPlot({
      p=hist(log(R2$Average.of.Daily.Rainfall.Total..mm.), breaks = 250, col = "purple",
             main = "Distribution of Singapore Log Mean Rainfall 2000-2020", xlab = "Log Mean Rainfall")
      return(p)
      
    })
    
    
    #wind
    
    F_W = S_D[,c(1,9)]
    F_W_O = na.omit(F_W)
    row.names(F_W_O) = NULL
    W1 = F_W_O[1:7136,]
    W2 = F_W_O[7137:14272,]
    
    output$wind_test1 <- renderText({
      temp_sha1=shapiro.test(W1$Average.of.Mean.Wind.Speed..km.h.[1:5000])
      paste("1. Normality Test Result(1982-2001): p-value < 2.2e-16")
      
    })
    
    output$wind_test2 <- renderText({
      temp_sha2=shapiro.test(W2$Average.of.Mean.Wind.Speed..km.h.[1:5000])
      paste("2. Normality Test Result(2001-2020): p-value < 2.2e-16")
      
    })
    
    output$wind_test3 <- renderText({
      temp_wil=wilcox.test(W1$Average.of.Mean.Wind.Speed..km.h.,W2$Average.of.Mean.Wind.Speed..km.h.,paired = TRUE,alternative = "two.sided")
      paste("3. Non-parametric Pair Test Result: p-value < 2.2e-16")
      
    })
    
    output$wind_hist1 <- renderPlot({
      p=hist(W1$Average.of.Mean.Wind.Speed..km.h., breaks = 300, col = "purple",
             main = "Distribution of Singapore Mean Wind 1981-2000", xlab = "Mean Wind")
      return(p)
      
    })
    
    output$wind_hist2 <- renderPlot({
      p=hist(W2$Average.of.Mean.Wind.Speed..km.h., breaks = 250, col = "purple",
             main = "Distribution of Singapore Mean Wind 2000-2020", xlab = "Mean Wind")
      return(p)
      
    })
    
    
    
    #################end of interfere analysis
    #Time series conversion
    x8cTS = ts(X8c) # rain 
    X11cTS = ts(X11c) # temp
    X12TS = ts(X12) # wind
    #differencing & determine if data is stationary using adf test
    
    #rain
    X8cTSarima1 <- arima(x8cTS, order=c(0,3,15))
    X8cTSforecasts1 <- forecast(X8cTSarima1, h=5)
    
    X8cTSarima2 <- arima(x8cTS, order=c(0,3,3))
    X8cTSforecasts2 <- forecast(X8cTSarima2, h=5)
    
    X8cTSarima3 <- arima(x8cTS, order=c(0,2,5))
    X8cTSforecasts3 <- forecast(X8cTSarima3, h=5)
    
    #temp
    X11cTSarima1 <- arima(X11cTS, order=c(0,1,4))
    X11cTSforecasts1 <- forecast(X11cTSarima1, h=5)
    
    X11cTSarima2 <- arima(X11cTS, order=c(0,1,3))
    X11cTSforecasts2 <- forecast(X11cTSarima2, h=5)
    
    X11cTSarima3 <- arima(X11cTS, order=c(0,1,15))
    X11cTSforecasts3 <- forecast(X11cTSarima3, h=5)
    
    #wind
    X12TSarima1 <- arima(X12TS, order=c(0,2,15))
    X12TSforecasts1 <- forecast(X12TSarima1, h=5)
    
    X12TSarima2 <- arima(X12TS, order=c(0,3,15))
    X12TSforecasts2 <- forecast(X12TSarima2, h=5)
    
    X12TSarima3 <- arima(X12TS, order=c(2,1,2))
    X12TSforecasts3 <- forecast(X12TSarima3, h=5)
    
    
    
    
    ### Stationary time series
    #rain
    output$arima_rain1 <- renderText({
      paste("TheARIMA MA Model (0,3,15) has the lowest MAPE, MASE and MAE values. 
            It shows the forecasted annual rainfall in Singapore for the next 5 years where it shows 
            that in the following year rainfall will be much lower, 
            but Singapore will then experience an increase followed by a fall. Overall, rainfall is in a decreasing trend." )
      
    })
    
    output$arima_rain11 <- renderPlot({
      p=plot(X8cTSforecasts1)
      return(p)
      
    })
    
    output$arima_rain2 <- renderText({
      paste("The lowest AIC value: annual rainfall is in a decreasing trend")
      
    })
    
    output$arima_rain22 <- renderPlot({
      p=plot(X8cTSforecasts2)
      return(p)
      
    })
    
    output$arima_rain3 <- renderText({
      paste("Relatively low AIC value and low MAPE and MASE values: rainfall will increase and then decrease")
      
    })
    
    output$arima_rain33 <- renderPlot({
      p=plot(X8cTSforecasts3)
      return(p)
      
    })
    
    #temp
    output$arima_temp1 <- renderText({
      paste("The lowest AIC value: temperature was going to increase, 
            fall back down and increase back again")
      
    })
    
    output$arima_temp11 <- renderPlot({
      p=plot(X11cTSforecasts1)
      return(p)
      
    })
    
    output$arima_temp2 <- renderText({
      paste("The lowest MAPE value: temperature was going to increase, 
            fall back down and increase back again")
      
    })
    
    output$arima_temp22 <- renderPlot({
      p=plot(X11cTSforecasts2)
      return(p)
      
    })
    
    output$arima_temp3 <- renderText({
      paste("ARIMA MA Model (0,1,15) has the lowest MAPE, MASE and MAE values. 
            It shows the forecasted annual temperature in Singapore for the next 5 years. 
            Annural temperature is expected to fall back down and increase back again. 
            Overall,temperature is in an upward trend. ")
      
    })
    
    output$arima_temp33 <- renderPlot({
      p=plot(X11cTSforecasts3)
      return(p)
      
    })
    
    #wind
    output$arima_wind1 <- renderText({
      paste("ARIMA MA Model (0,2,15) has the lowest MAPE, MASE and MAE values.
            It shows an initial fall in wind speed, an increase and then a slight fall. 
            Overall wind speeds are in an increasing trend. ")
      
    })
    
    output$arima_wind11 <- renderPlot({
      p=plot(X12TSforecasts1)
      return(p)
      
    })
    
    output$arima_wind2 <- renderText({
      paste("The lowest MAPE and MASE value: initial fall in wind speed 
            followed by an overall increase")
      
    })
    
    output$arima_wind22 <- renderPlot({
      p=plot(X12TSforecasts2)
      return(p)
      
    })
    
    output$arima_wind3 <- renderText({
      paste("Relatively low AIC value and low MAPE and MASE values: initial fall in wind
            speed followed by an overall increase")
      
    })
    
    output$arima_wind33 <- renderPlot({
      p=plot(X12TSforecasts3)
      return(p)
      
    })
    
    
    
    }








shinyApp(ui, server)
                                
                                
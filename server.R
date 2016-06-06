# server.R
# John C McDavid, 06-05-2016
# C:\Users\jcmcd\Coursera - Developing Data Products\Shiny-work
# 06-05-16 (vers 8)
#    org:  05-22-16, w subseq revs

library(shiny)
library(UsingR)
data(batting)

BA <- function(team) {
    bat <- batting
    bat2 <- subset(bat, teamID == team)
    tot_ab <- sum(bat2$AB)
    tot_hit <- sum(bat2$H)
    batavg <- tot_hit / tot_ab
    
    SP <- ( 1 * (sum(bat2$H)-sum(bat2$DOUBLE)-sum(bat2$TRIPLE)-sum(bat2$HR)) 
           + 2 * sum(bat2$DOUBLE) + 3 * sum(bat2$TRIPLE) + 4 * sum(bat2$HR) ) / tot_ab
    
    OBA <- ( sum(bat2$H) + sum(bat2$BB) + sum(bat2$HBP) ) / ( tot_ab + sum(bat2$BB) + sum(bat2$HBP) + sum(bat2$SF) )
    
    nr <- nrow(bat2)
    
    BBB <-c(nr, batavg, SP, OBA)
    
    #batavg
    BBB
}

cap <- c("Number of players", "Batting Average (BA)", "Slugging Pct (SP)", "On Base Avg (OBA)")


shinyServer(
    function(input, output) {
        output$outdate1 <- renderPrint({input$date1})
        output$dow <- renderPrint({weekdays(input$date1,abbreviate = FALSE)})
        output$outStatOpt <- renderPrint({input$StatOpt})
        
# not sure if braces r needed in renderPrint - seems to work either way
        output$outStat1 <- renderPrint({input$StatOpt[1]})
        output$outStat2 <- renderPrint({input$StatOpt[2]})
        output$outStat3 <- renderPrint({input$StatOpt[3]})
        
        output$outTeam <- renderPrint({input$Team})

        team <- renderPrint({input$Team})
        
        output$batavg1 <- renderPrint({
            # BA("ATL")                      # works... now just have to translate select number to team
            b <- BA(input$Team)
            
            #  if (input$StatOpt[1] == 1) {b[1]} else {b[2]}    # line works, now enhance code
            
            cc <- b[1]
            if (!is.na(input$StatOpt[1])) {cc <- c(cc, b[as.numeric(input$StatOpt[1]) + 1]) }
            if (!is.na(input$StatOpt[2])) {cc <- c(cc, b[as.numeric(input$StatOpt[2]) + 1]) }
            if (!is.na(input$StatOpt[3])) {cc <- c(cc, b[as.numeric(input$StatOpt[3]) + 1]) }

            cc

            })
        
        output$statcapt <- renderPrint({

            dd <- cap[1]
            # needs work
            if (!is.na(input$StatOpt[1])) {dd <- paste(dd, cap[as.numeric(input$StatOpt[1]) + 1], sep = ", ", collapse = NULL) }
            if (!is.na(input$StatOpt[2])) {dd <- paste(dd, cap[as.numeric(input$StatOpt[2]) + 1], sep = ", ", collapse = NULL) }
            if (!is.na(input$StatOpt[3])) {dd <- paste(dd, cap[as.numeric(input$StatOpt[3]) + 1], sep = ", ", collapse = NULL) }
            # if (!is.na(input$StatOpt[2])) {dd <- c(dd, cap[as.numeric(input$StatOpt[2]) + 1]) }
            # if (!is.na(input$StatOpt[3])) {dd <- c(dd, cap[as.numeric(input$StatOpt[3]) + 1]) }

            #if (!is.na(input$StatOpt[1])) {dd <- c(dd, cap[as.numeric(input$StatOpt[1]) + 1]) }
            #if (!is.na(input$StatOpt[2])) {dd <- c(dd, cap[as.numeric(input$StatOpt[2]) + 1]) }
            #if (!is.na(input$StatOpt[3])) {dd <- c(dd, cap[as.numeric(input$StatOpt[3]) + 1]) }
            dd
            
        })
        
                
    }
)
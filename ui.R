# ui.R
# John C McDavid, 06-05-2016
# C:\Users\jcmcd\Coursera - Developing Data Products\Shiny-work
# 06-05-16 (vers 8)
#    org:  05-22-16, w subseq revs

shinyUI(pageWithSidebar(
    headerPanel("Calculating Batting Stats from batting Dataset"),

    sidebarPanel(

        h4('This app will do a fun date calculation and then calculate an aggregate baseball stat for the players on the team you specify.'),

        h5('Dataset is "batting" from Using R; contains raw batting numbers for players in 2002 season w > 100 at bats;
           allows calculation of batting stats.'),

        h4('************************'),        

        dateInput("date1",
                  label = h4("For fun, enter birth date (or any date) to demo reactive output (format = YYYY-MM-DD)"), 
                  value = "2016-06-01"),
        

        checkboxGroupInput("StatOpt", h4("Choose Baseball Stat to Calc (BA is default)"),
                           c("BA - batting avg" = "1",
                             "SP - slugging pct" = "2",
                             "OBA - on base avg" = "3"),
                           selected = "1"),
        
        # normally, below second in choices list is number
        selectInput("Team", label = h4("Select Team (ATL is default)"), 
                    choices = list("ATL" = "ATL",
                                   "ANA" = "ANA",
                                   "ARI" = "ARI",
                                   "BAL" = "BAL",
                                   "BOS" = "BOS",
                                   "CHI WS" = "CHA",
                                   "CHI Cubs" = "CHN",
                                   "CIN" = "CIN",
                                   "CLE" = "CLE",
                                   "COL" = "COL",
                                   "DET" = "DET",
                                   "FL" = "FLO",
                                   "HOU" = "HOU",
                                   "KC" = "KCA",
                                   "LA" = "LAN",
                                   "MIL" = "MIL",
                                   "MIN" = "MIN",
                                   "MON" = "MON",
                                   "NY Yank" = "NYY",
                                   "NY Mets" = "NYN",
                                   "OAK" = "OAK",
                                   "PHI" = "PHI",
                                   "PIT" = "PIT",
                                   "SD" = "SDN",
                                   "SEA" = "SEA",
                                   "SF" = "SFN",
                                   "STL" = "SLN",
                                   "TBA" = "TBA",
                                   "TEX" = "TEX",
                                   "TOR" = "TOR"), 
                    selected = "ATL"),

        submitButton('Submit')


    ),

    mainPanel(
        h3('Outputs'),
        
        h3('Fun part....'),
        h4('Your birthdate (or any date) input was'),
        verbatimTextOutput("outdate1"),
        h4('Which was (is) a '),
        verbatimTextOutput("dow"),
        
        h3('Now, for batting stats for players on your team....'),
        h4("Notes:"),
        helpText("BA = H / AB"),  
        helpText("SP = ( 1 * 1B + 2 * 2B + 3 * 3B + 4 * HR ) / AB"),  
        helpText("OBA = ( H + BB + HBP ) / ( AB + BB + HBP + SF )"),
        helpText("IBB are included in BB"),


        h4('Your stat choice(s)'),
        verbatimTextOutput("outStatOpt"),
        # verbatimTextOutput("outStat1"),
        # verbatimTextOutput("outStat2"),
        # verbatimTextOutput("outStat3"),

        h4('Team selection you entered'),
        verbatimTextOutput("outTeam"),
        h4('Stats for Team selection you entered'),
        textOutput("statcapt"),
        verbatimTextOutput("batavg1")


    )
))

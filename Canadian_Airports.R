install.packages("ggmap")
install.packages("RSQLite")
install.packages("dbConnect")

## Dataset Explained: http://openflights.org/data.html
## Datasets downloaded from http://sourceforge.net/p/openflights/code/HEAD/tree/openflights/data/
library(ggmap)
library(RSQLite)
library(DBI)

## Read data from directory
airport_raw <- read.csv("airports.dat", header = F ,sep=",")
route_raw <- read.csv("routes.dat", header = F, sep=",")

## Examine datasets
dim(airport_raw)
dim(route_raw)
colnames(airport_raw)
head(airport_raw)
head(route_raw)

# Remove the airports without IATA codes and rename the variables
airport <-subset(airport_raw,airport_raw$V5!='')
airport <-airport[,c('V3', 'V4', 'V5','V7','V8','V9')]
colnames(airport) <- c("City", "Country", "IATA", "latitude", "longitude", "altitude")

route <- route_raw[,c('V3', 'V5')]
colnames(route) <- c("Departure", "Arrival")

## Examine datasets
dim(route)
summary(route)

# Store data to SQLite database
conn <- dbConnect(RSQLite::SQLite(), dbname = "air.db")
dbSendQuery(conn, "drop table if exists airport;")
dbWriteTable(conn, "airport", airport)  
dbSendQuery(conn, "drop table if exists route;")
dbWriteTable(conn, "route", route) 
dbDisconnect(conn)


# Manipulate data in SQLite database
conn <- dbConnect(RSQLite::SQLite(), dbname = "air.db")
sqlcmd01 <- dbSendQuery(conn, " 
                        select a.type, a.city as iata, a.frequency, b.city, b.country, b.latitude, b.longitude
                        from (select  'depart' as type, departure as city, count(departure) as frequency
                        from route
                        group by departure
                        order by frequency desc, type) as a 
                        left join airport as b on a.city = b.iata
                        where b.country ='Canada'
                        order by frequency desc
                        ;")
top <- fetch(sqlcmd01, n = -1)


sqlcmd02 <- dbSendQuery(conn, " 
                        select route.rowid as id, route.departure as point, airport.latitude as latitude, airport.longitude as longitude
                        from route left join airport on route.departure = airport.iata where airport.country='Canada'
                        union 
                        select route.rowid as id, route.arrival as point, airport.latitude as latitude, airport.longitude as longitude
                        from route left join airport on route.arrival = airport.iata where airport.country='Canada'
                        order by id
                        ;")
combine <- fetch(sqlcmd02, n = -1)


## Store additional data to SQLite database
conn1 <- dbConnect(RSQLite::SQLite(), dbname = "top.db")
dbSendQuery(conn1, "drop table if exists top;")
dbWriteTable(conn1, "top", top)  
dbDisconnect(conn1)

# Manipulate data in SQLite database
conn1 <- dbConnect(RSQLite::SQLite(), dbname = "top.db")
sqlcmd03 <-dbSendQuery(conn1, "SELECT City, sum(frequency) as tot_freq FROM top GROUP BY City ORDER BY tot_freq desc Limit 5;")
ranked <-fetch(sqlcmd03, n=-1)



# Draw the flight routes and the airports on Google map
ggmap(get_googlemap(center = 'canada', zoom = 3, maptype = 'roadmap'), extent = 'device') +
geom_line(data = combine, aes(x = longitude, y = latitude, group = id), size = 1,
          alpha = 0.05,color = 'red4') +
geom_point(data = top, aes(x = longitude, y = latitude, size = frequency), colour = "blue", alpha = 0.3) +
scale_size(range=c(0,15))

## What are the top 5 airports in Canada in terms of flight frequency?
ranked

## What is the most northern airport in Canada and where is it?
subset(top,top$latitude==max(top$latitude))


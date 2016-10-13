movies <- read.csv(file.choose())
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions","Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

factor(movies$Year)
movies$Year <- factor(movies$Year)
summary(movies)
str(movies)

#--------------- Asthetics
library(ggplot2)
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))

#add geometry
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating)) +
  geom_point()

#add color
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, color= Genre)) +
  geom_point()

#add size
ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, color= Genre, size=Genre)) +
  geom_point()

#Better way adding size

ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, color= Genre, size=BudgetMillions)) +
  geom_point()

# this is #1( we will improve it)

#----------------------Plotting with layers


p <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating, color= Genre, size=Genre))

#point
p + geom_point()

#line
 
p + geom_line()

#multiple layers

p+ geom_point() +geom_line()
p+ geom_line() +geom_point()

#----------------Overriding aesthetics
q <- ggplot(data=movies,aes(CriticRating, y=AudienceRating,
                            color=Genre, size=BudgetMillions))
# add geom layer
 
q + geom_point()
# overriding aes
 #example 1
q + geom_point(aes(size=CriticRating))
# in this abouve example, size of the 
#points is overridden by criticratings
#that means size according to budgetmillions has no
#effect on graph

#Example 2
q + geom_point(aes(color=BudgetMillions))

#q remains the same
q+ geom_point() #just the same

# Example 3
q + geom_point(aes(x=BudgetMillions)) #lables remain the same 
# to fix that we add xlab()

q + geom_point(aes(x=BudgetMillions)) + xlab("Budget Millions $$")

#example 4
p+ geom_line(size=1) +geom_point(size=2) #we have not s=written 'aes()' in this example
#its not mapping, we are just setting aesthetics

#--------------------------Mapping vs Setting

r <- ggplot(data= movies,aes(x= CriticRating,
                             y=AudienceRating))
r + geom_point()
# add color
#1 Mapping(what we have done so far)

r + geom_point(aes(color= Genre))

#2 Setting:

r + geom_point(color="DarkGreen")

#ERROR
r + geom_point(aes(color="DarkGreen")) # this is not right

#1. Mapping

r + geom_point(aes(size= BudgetMillions))

#2. Setting

r + geom_point(size= 5)

#ERROR
r + geom_point(aes(size= 5)) #wrong

#---------------- Histogram and density charts
s <- ggplot(data=movies,aes(BudgetMillions))
s + geom_histogram(binwidth = 10)

#add color

s + geom_histogram(binwidth = 10, fill="Green")

s + geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border
# here we are just setting a border; we are not mapping it

s + geom_histogram(binwidth = 10,aes(fill=Genre), color="Black")

#   3 (we will improve it)

#sometimes we may need density charts:
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

#-------------Starting Layer Tip

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth=10,
                   fill="white",color="Blue")
# another way to get the same plot

t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, aes(x= AudienceRating), fill="White",color="blue")

#>>> 4th chart
t + geom_histogram(binwidth = 10, aes(x= CriticRating), fill="White",color="blue")
#>> 5th chart

t <- ggplot() #skeleton plot

#--------statistical transformations

geom_smooth()

u <- ggplot(data=movies, aes(x=CriticRating , y= AudienceRating,
                             color=Genre))
u + geom_point() + geom_smooth(fill=NA)

#boxplots

u <- ggplot(data=movies,aes(x=Genre, y= AudienceRating,
                            color=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) +geom_point()
#tip

u + geom_boxplot(size=1.2) + geom_jitter()

#another way

u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)
#>> 6th chart

#challenge

k <-ggplot(data=movies,aes(x=Genre, y= CriticRating,
                           color=Genre))
k + geom_boxplot(size=1.2)+ geom_jitter()

k + geom_jitter() + geom_boxplot(size=1.2, alpha = 0.5)

#----------------nUsing facets

v <- ggplot(data= movies,aes(x=BudgetMillions))
v + geom_histogram(binwidth=10,aes(fill= Genre),color="black")

#facets allows us to make lot of charts

v + geom_histogram(binwidth=10,aes(fill= Genre),color="black") +
  facet_grid(Genre ~ .)
# note: the value left to ~ sign is rows
# and to the right is columns
#basically facet_grid(Genre ~ .) : charts are horizontal(row-wise)
# and facet_grid(. ~ Genre) : Charts vertical (column-wise)


#To make the charts bigger and visible use scales= "free"
v + geom_histogram(binwidth=10,aes(fill= Genre),color="black") +
  facet_grid(Genre ~ ., scales="free")

#scatterplots:

w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))
w + geom_point(size=3)

#facets
w + geom_point(size=3)+ facet_grid(Genre ~ .)

w + geom_point(size=3) + facet_grid(. ~ Year)

w + geom_point(size=3) + facet_grid(Genre ~ Year)+
  geom_smooth()

w + geom_point(aes(size=BudgetMillions)) + 
  geom_smooth() + facet_grid(Genre ~ Year)
# >> chart1(but still will improve)

#---------------------- Coordinates

#today:
#limits
#zoom


m <- ggplot(data=movies, aes(x= CriticRating, y=AudienceRating,
                             size=BudgetMillions,
                             color= Genre))
m + geom_point()

m + geom_point() + 
  xlim(50,100) + ylim(50,100)
#won't work well always

n <- ggplot(data=movies,aes(x=BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="black")

n + geom_histogram(binwidth = 10, aes(fill=Genre), color="black")+
                     ylim(0,50)

#instead use zoom:

n + geom_histogram(binwidth = 10, aes(fill=Genre), color="black") +
                     coord_cartesian(ylim = c(0,50))

#improve #1 chart
w + geom_point(aes(size=BudgetMillions)) + 
  geom_smooth() + facet_grid(Genre ~ Year) +
  coord_cartesian(ylim=c(0,100))
                     










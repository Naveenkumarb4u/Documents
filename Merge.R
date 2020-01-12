# Make a data frame mapping story numbers to titles
stories <- read.table(header=TRUE, text='
   storyid  title
    1       lions
    2      tigers
    3       bears
')


# Make another data frame with the data and story numbers (no titles)
data <- read.table(header=TRUE, text='
    subject storyid rating
          1       1    6.7
          1       2    4.5
          1       3    3.7
          2       2    3.3
          2       3    4.1
          2       1    5.2
')

# Merge the two data frames
merge(stories, data, "storyid")

# Works similar
merge(data, stories, "storyid")


# In this case, the column is named 'id' instead of storyid
stories2 <- read.table(header=TRUE, text='
   id       title
    1       lions
    2      tigers
    3       bears
')

# Merge on stories2$id and data$storyid.
merge(x=stories2, y=data, by.x="id", by.y="storyid")
#>   id  title subject rating
#> 1  1  lions       1    6.7
#> 2  1  lions       2    5.2
#> 3  2 tigers       1    4.5
#> 4  2 tigers       2    3.3
#> 5  3  bears       1    3.7
#> 6  3  bears       2    4.1

# Note that the column name is inherited from the first data frame (x=stories2).


# Make up more data
animals <- read.table(header=T, text='
   size type         name
  small  cat         lynx
    big  cat        tiger
  small  dog    chihuahua
    big  dog "great dane"
')

observations <- read.table(header=T, text='
   number  size type
        1   big  cat
        2 small  dog
        3 small  dog
        4   big  dog
')

merge(observations, animals, c("size","type"))
#>    size type number       name
#> 1   big  cat      1      tiger
#> 2   big  dog      4 great dane
#> 3 small  dog      2  chihuahua
#> 4 small  dog      3  chihuahua

# A sample data frame
data <- read.table(header=TRUE, text='
    id weight   size
     1     20  small
     2     27  large
     3     24 medium
')

# Reorder by column number
data[c(1,3,2)]
#>   id   size weight
#> 1  1  small     20
#> 2  2  large     27
#> 3  3 medium     24

# To actually change `data`, you need to save it back into `data`:
# data <- data[c(1,3,2)]


# Reorder by column name
data[c("size", "id", "weight")]
#>     size id weight
#> 1  small  1     20
#> 2  large  2     27
#> 3 medium  3     24




















# data frame 1
df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Oven", 3), rep("Television", 3)))

# data frame 2
df2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("California", 2), rep("Texas", 1)))

# df1:
#   
#   CustomerId  Product
# 1  1                    Oven
# 2  2                    Oven
# 3  3                    Oven
# 4  4                    Television
# 5  5                    Television
# 6  6                    Television
# 
# df2:
#   CustomerId  State
# 1 2                    California
# 2 4                    California
# 3 6                    Texas


# Inner join in R:  Return only the rows in which the left table have matching keys in the right table.

df<-merge(x=df1,y=df2,by="CustomerId")
################## Output ####################

# CustomerId  Product    State
# 1 2                   Oven          California
# 2 4                   Television  California
# 3 6                   Television  Texas



# Outer join in R: Returns all rows from both tables, join records from the left which have matching keys in the right table.
df<-merge(x=df1,y=df2,by="CustomerId", all =TRUE)

# CustomerId   Product       State
# 1   1         Oven            <NA>
# 2   2         Oven           California
# 3   3         Oven            <NA>
# 4   4       Television       California
# 5   5       Television        <NA>
# 6   6       Television       Texas



# Left outer join in R: Return all rows from the left table, and any rows with matching keys from the right table.
df<-merge(x=df1,y=df2,by="CustomerId",all.x=TRUE)

# CustomerId  Product     State
# 1  1         Oven          <NA>
# 2  2         Oven          California
# 3  3         Oven          <NA>
# 4  4        Television  California
# 5  5        Television  <NA>
# 6  6        Television  Texas



# Right outer join in R: Return all rows from the right table, and any rows with matching keys from the left table.
df<-merge(x=df1,y=df2,by="CustomerId",all.y=TRUE)

# CustomerId Product      State
# 1 2                   Oven           California
# 2 4                   Television   California
# 3 6                   Television   Texas

# Cross join in R: A Cross Join (also sometimes known as a Cartesian Join) results in every row of one table being joined to every row of another table
df<-merge(x = df1, y = df2, by = NULL)

# CustomerId.x     Product       CustomerId.y     State
# 1 1               Oven                  2      California
# 2 2               Oven                  2      California
# 3 3               Oven                  2      California
# 4 4               Television            2      California
# 5 5               Television            2      California
# 6 6               Television            2      California
# 7 1               Oven                  4      California
# 8 2               Oven                  4      California
# 9 3               Oven                  4      California
# 10 4             Television  		      4       California
# 11 5             Television  		      4       California
# 12 6             Television  		      4       California
# 13 1             Oven                   6        Texas
# 14 2             Oven                   6        Texas
# 15 3             Oven                   6        Texas
# 16 4             Television         	  6        Texas
# 17 5             Television         	  6        Texas
# 18 6             Television         	  6        Texas
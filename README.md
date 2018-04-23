# consultthat

Consultthat provides tools to streamline your consulting projects from within R. While there's some great issue trackers, time keeping systems and other tools to use out there for these issues: if your main workflow is in R, then it's sometimes more efficient to manage your project within R too.

Building on the tools provided by `usethis`:`consultthat`.

## Installation

You can install the test version of the package from Github:

``` r
install.packages("devtools") # you only need this if you don't have devtools already
library(devtools) 
install_github("stephdesilva/consultthat") # install the package
library(consultthat) # use the package
```

## Starting a consulting project

`Consultthat` organises consulting projects by client. This is useful as you may be working with repeat clients over time.

Before you start a project, you need to create a client directory for your project to be stored in. Firstly, decide where the client directory should be located, in this case I'll use `~/practice` for convenience. You'll also need a name for your client!

``` r
clientPath <- "~/practice"
clientName <- "RStars"
createClient(clientName, clientPath)
```

`Consultthat` helps you keep track of people in an organisation from project to project using 'addPersonnel()`.

To create a project, you'll need the path your consulting projects are set up in, the client name and a project name.

``` r
projName <- "firstProject"
createProject(clientPath, clientName, projName)
```

This function automatically sets up a regular R package using `usethis`, but it also adds some other features to help you keep track of everything that goes into a consulting project.

### Time Management

Time management can be a pain in the posterior distribution, but when you're charging by the hour, it's essential. 

To punch on for a project and start recording the time you spend on it, use `punchOn()`. You can designate on a category of work you are completing to further break down your time keeping and you can add notes if you like.

```r 
library(consultthat)
name <- "Steph"
category <- "Data analysis"
notes <- "fun times to be had!"

punchOn(name, category, notes)
```

To punch off the project, you can choose another category to end with, if you like, but you can only be punched into one category per project at a time.

```r 
name <- "Steph"
category <- "more analysis"
notes <- "this was not awful"

punchOff(name, category, notes)
```

If multiple people are working on the same project, they will each have their own timesheet generated.

```r 
name <- "Gary"
category <- "something over complicated"
notes <- "dubious value"

punchOn(name, category, notes)
```

You can retrieve a person's timesheet at any time as a data frame with `timesheet(name)`. This is a tidy data frame: you know what that means!

### Log issues

There are some excellent issue trackers out there, but if a simple system is all you need, then keeping it all in R can have some advantages. You can log issues using `addIssue()`.

```r 
issueID <- "bug fix 4000"
addIssue(issueID, "Steph")
```

You can add multiple issues, with more detail if you wish.

```r 
issueID2 <- "ID0001"
addIssue(issueID2, "Gary", category = "unit tests", notes = "We need them")
```

You can close an issue at any time:

```r 
closeIssue(user = "Steph", ID = "ID0001", notes = "I added them.")
```

You can retrieve the database of open and closed issues as a dataframe at any time.

```r 
issues()
```

### Document your data

A complete data analysis is not an optional activity in a data science consulting project, but a quick "is the data what we think it is" documentation can be useful at the early stages. `createBasicDocumentation()` can be used to run through all the `.csv` files in the `/data` directory and create a short document detailing what's in them using `skimr`.

This function is currently of limited use, but is a quick check that you've got everything you expected. See `?createBasicDocumentation()` for details.



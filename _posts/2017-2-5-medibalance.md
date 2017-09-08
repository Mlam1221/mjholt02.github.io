---
title: 'medibalance - R package for Medidata Balance'
tags: [R, Package,Medidata]
---
An R package which provides some simple tools to quicky create a basic randomized list for Medidata Balance.


## Install

    install.packages("devtools")
    devtools::install_github("mjholt02/medibalance")

## Functions

    calc_N: Used to calculate N based on predetermined block sizes

    calc_N(blocks, levels, approx)
    calc_N(blocks=c(3,24), levels=3,approx=225)

    calc_blocks: Used to determine possible block sizes for a given N

    calc_blocks(num_blocks, levels, N)
    calc_blocks(num_blocks=3, levels=3, N=216)

    create_list: Create your randomization list for Medidata balance.

    create_list(list_name, myseed, site_n, n, block_sizes, arm_codes, arm_names, out_loc)
    create_list(list_name = "test_list", myseed = 213, site_n = 1, n = 216, block_sizes = c(3,24), arm_codes = c("a","b","c"), arm_names = c("Drug A description", "Drug B description", "Drug C description"), out_loc = "C:/Users/Desktop/")


## Workflow
1.  Determine \# of study arms
2.  Calculate block/list size
3.  Create randomization list

### Determine \# of study arms

The protocol should specify study arms, for this example we will use 3 study arms (A,B,C)

Generate list
-------------

The tools below can be found in a R package at <https://github.com/mjholt02/medibalance>.

#### Calculate block/list size

Depending on what information you have available you can calculate possible block sizes from a given N, or an N for a specific list of block sizes from the R functions shown below.

#### Using calc\_blocks() to get block options from a set N

``` r
calc_blocks(num_blocks=3, levels=3, N=216)
```

    ##   block 1 block 2 block 3  #
    ## 1       3       6       9 12
    ## 2       3       6      15  9
    ## 3       3       9      12  9
    ## 4       3       9      15  8
    ## 5       6       9      12  8
    ## 6       9      12      15  6

The output above gives you your options for blocks.  For example you could use 12 blocks of size 3, 6, and 9 to get your 216 (12x3 + 12x6 + 12x9) randomization spots.

#### Using calc\_N() to get N from predetermined block options

The function below takes the block sizes you want, in this case we want to use 2 blocks of size 3 and 24.  We have 3 treatment arms in our study (A,B,C) and we know the approximate length we need our list to be is around 225 randomization slots.

``` r
calc_N(blocks=c(3,24), levels=3,approx=225)
```

    ## [1] "For your block sizes you can use an N of:"

    ## [1] 189 216 243 270

Based on the output above we can see that we can use an N of 189,216,243, or 270 to generate our list with 3 treatment levels and block sizes of 3 and 24.

#### Create randomization list using create\_list()

``` r
create_list(list_name = "test_list",
  myseed = 213, 
  site_n = 1,
  n = 216,
  block_sizes = c(3,24),
  arm_codes = c("a","b","c"),
  arm_names = c("Drug A description", "Drug B description", "Drug C description"),
  out_loc = "")
```

This function creates a csv in the out\_loc specified.  Since we only have a single site (site\_n = 1) we produce a list that is 216 rows and 5 columns.  The total length of the list will be (site\_n x n).

``` r
randomization_list <- read.csv("test_list.csv")
dim(randomization_list)
```

    ## [1] 216   5

``` r
head(randomization_list)
```

    ##   List.Name Block.ID Randomization.ID Arm.Code           Arm.Name
    ## 1 test_list        4                1        a Drug A description
    ## 2 test_list        4                2        c Drug C description
    ## 3 test_list        4                3        b Drug B description
    ## 4 test_list        4                4        b Drug B description
    ## 5 test_list        4                5        a Drug A description
    ## 6 test_list        4                6        c Drug C description
	
	
	


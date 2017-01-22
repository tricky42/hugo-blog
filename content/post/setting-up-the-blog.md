+++
title = "Setting up the blog!"
description = ""
tags = ["aws","hugo","s3","cloudfront"]
categories = ["blogging"]
date = "2017-01-10"
banner = "http://placehold.it/1024x200"
draft = true
+++


# Introduction
In this post I describe my journey to find a neat, small solution to finally setup a small webpage and blog solution for my self. I start first to look for a small CMS solution but all the PHP based solution reminded me that a) I dont like PHP and b) I wanted to also make sure, the resulting site is easy and cheap to host. Therefore I quickly refined my requirements to static site generators and as I want to make more use of Golang, I looked for a Go based solution. I very quickly found Hugo (https://gohugo.io/) and started reading about it and decided to give it a try ;) 



# Installing Hugo
The nice thing about Golang based solutions is that they are almost always are super easy to install. But even better, Hugo can be installed using Homebrew. In this post I will only cover all the steps which are needed to get Hugo setup on my Mac with Homebrew already installed. But I will include the links to the standard install documentation of Homebrew, Hugo and any other tool I am using in the link section.

```
$ brew update && brew install hugo
==> Downloading https://homebrew.bintray.com/bottles/hugo-0.18.1.sierra.bottle.tar.gz
==> Pouring hugo-0.18.1.sierra.bottle.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> Summary
🍺  /usr/local/Cellar/hugo/0.18.1: 32 files, 16.3M 

```
This installation even worked on the bus from Phnom Penh to Ho Chi Minh City. Now we have everything to get started with Hugo. 
So lets quickly test the installation by printing out the Hugo version:
```
$ hugo version
Hugo Static Site Generator v0.18.1 BuildDate: 2016-12-30T00:12:41+07:00
```
In order the create a new site in Hugo you only have to type 

```
$ hugo new site hugo-site
Congratulations! Your new Hugo site is created in <your path>

Just a few more steps and you're ready to go:

1. Download a theme into the same-named folder.
   Choose a theme from https://themes.gohugo.io/, or
   create your own with the "hugo new theme <THEMENAME>" command.
2. Perhaps you want to add some content. You can add single files
   with "hugo new <SECTIONNAME>/<FILENAME>.<FORMAT>".
3. Start the built-in live server via "hugo server".

Visit https://gohugo.io/ for quickstart guide and full documentation.
```

Hugo creates a basic site skeleton in a new directory with the name of the site you have chosen, in my example "hugo-site". Lets take a quick look on what has been created:
```
$ tree
.
├── archetypes
├── config.toml
├── content
├── data
├── layouts
├── static
└── themes
```

I will not go into the details, the [Quickstart Guide](https://gohugo.io/overview/quickstart/) does a really good job, I will foucs just on the things necessary for my own site. You manage all the configuration of your site in the config.toml file. At first I was a bit irritated by the file extension. So I quickly googled TOML and after reading [Intro into TOML](https://npf.io/2014/08/intro-to-toml/) I kind of agree as I never enjoyed writing neither JSON nor YAML, so I am in full support for TOML ;) 

## Picking a theme
All static site generators have some kind of theme mechanism to make it easy to render your content in different layouts. Hugo is no exception so I took a tour on their [Hugo THemes Overview](http://themes.gohugo.io/). As I am not a designer / html/css guru, I decided to go with a simplistic theme to make it easy later on to customize it later on with the support of some of my designer friends back home. I decided on using the [Hugo Bootstrap](http://themes.gohugo.io/bootstrap/). I [forked](https://github.com/tricky42/hugo-bootstrap) it, as I wanted to track any changes I will do over time and potentially to contribute back. In order to use a theme you clone it into the themes directory and configure it in the config.toml file.
```
$ cd themes
$ git clone https://github.com/tricky42/hugo-bootstrap
Cloning into 'hugo-bootstrap'...
remote: Counting objects: 522, done.
remote: Total 522 (delta 0), reused 0 (delta 0), pack-reused 522
Receiving objects: 100% (522/522), 2.27 MiB | 183.00 KiB/s, done.
Resolving deltas: 100% (204/204), done.
$ cd ..
$ echo 'theme = "hugo-bootstrap"' >> config.toml
```
`echo 'theme = "hugo-bootstrap"' >> config.toml` just adds the config line `theme = "hugo-bootstrap` to the `config.toml` to configure that `hugo-bootstrap` is used for rendering from now on. Each theme can bring it's own configuration parameters and you normmally will find an example configuration file in the `exampleSite` directory inside of the directory of the theme you are using. 

Now everything is setup, lets start Hugo to get the content gnerated and take a look. 
```
$ hugo -v server &
$ open http://localhost:1313
```
By starting Hugo with the verbose flag `-v` it's a bit more chatty which is helpful in the begining or for debugging. The server command starts Hugo in server mode which is intended to local development. In server mode Hugo watches your site directory for changes and automatically regenerates your site when needed. 

After executing `$ open http://localhost:1313` a browser window should open and display our generated site. As we haven't so far added a ..........

We can easily add a new blog post by `hugo new post/my-first-post.md`. Hugo creates in the `<hugo-dir>/content/post` an draft markdown file in which only a few, preconfigured frontmatter variables are included. You can start modifying this file `subl content/post/my-first-post.md` and in parallel check you browser to check on your changes. In the background Hugo (because we started it in server mode) will generate the content whenever we modify a file. 

# Summary
As we are almost in Ho Chi Minh City and we have a working local setup and can check our site in our browser I think it is a good time to end this first blog post ;) The next blog post will be about how to host the generated site cheap & performat. 

For convenience you cab find a shell script with all the used commands in my git repo ### LINK ####.
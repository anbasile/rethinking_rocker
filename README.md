# Statistical Rethinking in a Box

## What Is This?

This is a fully configured, ready-to-use environment for working through Statistical Rethinking with CmdStanR, VSCode Server, and RStudio Server, all neatly packed into a Docker container.

You can pull a pre-built image and start working immediately or build it yourself if you like having everything under your control. Either way, you’ll skip the hassle of installing dependencies and focus on learning Bayesian modeling.

## How to Use It (The Fast Way)

If you just want to get started without worrying about setup, run this:

```
docker run --rm -p 8787:8787 -p 8080:8080 -e PASSWORD=yourpassword -it ghcr.io/YOUR-USERNAME/rethinking-docker:latest

```

 - RStudio Server: Open http://localhost:8787 in your browser.
 - VSCode Server: Open http://localhost:8080.
   - If you see a login screen, use password: yourpassword.
 - Username: (leave blank)

That’s it. No troubleshooting, just rethinking.

## Building the Image

If you prefer to build the image yourself, clone this repo and run:

``` bash
git clone https://github.com/anbasile/rethinking-docker.git
cd rethinking-docker
docker build -t rethinking-r .
```


Once built, run:

``` bash
docker run --rm -p 8787:8787 -p 8080:8080 -e PASSWORD=yourpassword -it rethinking-r
```


This does exactly what the pre-built image does—just with a few extra steps.

## How Do I Know It Works?

During the build process, the container will:

- Compile a Stan model (`bernoulli` example).
- Run a Bayesian inference test using sample data.
- Check that the output file exists.
- Run `stansummary` to summarize the results.
- Fail immediately if anything breaks, so you won’t waste time later.

If the build succeeds, CmdStan is fully operational inside the container.

## FAQ

### “Why does this include VSCode Server?”

Because it makes getting started easier. Just open a browser and start coding—no need to set up an IDE on your local machine.

### “Can I use Jupyter instead?”

Not included by default, but if you need Jupyter, contact me and I’ll add it.

### “Who is this for?”

This is for people getting started with Statistical Rethinking who don’t want to spend hours configuring their system. If you’re already an expert, you probably have your own setup.

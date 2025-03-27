# undi-1.0.0 image

Very early stage dev.
Python version is 3.12.7

Undi can be called via `/opt/conda/bin/python -m undi`. 
To build the image:

```shell
docker build . -t mikibonacci/undi-1.0.0:amd64 --platform linux/amd64
```

## To use it for aiida-pythonjob jobs:

docker run -it <image-name> python # followed by the script you want to run.

## To use undi just run:

```shell
docker run -it <image-name> python -m undi # and the cmd line argument you usually use.
```

to automatically remove the container after the execution, add ``--rm` after -it.

if you run without any other input arguments, you should obtain:

```shell
$docker run -it --rm <image-name> python -m undi"
        
usage: __main__.py [-h] [--max-hdim MAX_HDIM] [--atom-as-muon ATOM_AS_MUON] [--B_mod B_MOD] [--convergence-check CONVERGENCE_CHECK] [--algorithm ALGORITHM] [--sample_size_average SAMPLE_SIZE_AVERAGE]
                   [--dump DUMP]
                   structure
__main__.py: error: the following arguments are required: structure
```

## To use it with Appcontainer or singularity:

```shell
apptainer exec docker://mikibonacci/undi-1.0.0:amd64 python -m undi
```

If the architecture is `arm64`, just change the `amd64` in the above command.

## docker hub images:

https://hub.docker.com/r/mikibonacci/undi-1.0.0/tags

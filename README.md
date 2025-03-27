# undi-1.0.0 image

Very early stage dev.

Undi can be called via `/opt/conda/bin/python -m undi`. 
To build the image:

```shell
docker build . -t mikibonacci/undi-1.0.0:amd64 --platform linux/amd64
```

## To use undi just run:

```shell
docker run -it <image-name> "python -m undi" # and the cmd line argument you usually use.
```

to automatically remove the container after the execution, add ``--rm` after -it.

if you run without any other input arguments, you should obtain:

```shell
$docker run -it af2e94f769c6 "python -m undi"
        _
  _ __ | |__   ___  _ __   ___   _ __  _   _
 | '_ \| '_ \ / _ \| '_ \ / _ \ | '_ \| | | |
 | |_) | | | | (_) | | | | (_) || |_) | |_| |
 | .__/|_| |_|\___/|_| |_|\___(_) .__/ \__, |
 |_|                            |_|    |___/
                                      2.20.0

Python version 3.12.2
Spglib version 2.5.0


Supercell matrix (DIM or --dim) was not explicitly specified.
By this reason, phonopy_yaml mode was invoked.
But "phonopy_params.yaml", "phonopy_disp.yaml" or "phonopy.yaml" could not be found.
  ___ _ __ _ __ ___  _ __
 / _ \ '__| '__/ _ \| '__|
|  __/ |  | | | (_) | |
 \___|_|  |_|  \___/|_|


```

## To use it with Appcontainer or singularity:

```shell
apptainer exec docker://mikibonacci/undi-1.0.0:amd64 phonopy
```

If the architecture is `arm64`, just change the `amd64` in the above command.

## docker hub images:

https://hub.docker.com/r/mikibonacci/undi-1.0.0/tags

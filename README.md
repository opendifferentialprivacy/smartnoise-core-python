[![Build Status](https://travis-ci.com/opendifferentialprivacy/whitenoise-core-python.svg?branch=develop)](https://travis-ci.com/opendifferentialprivacy/whitenoise-core-python)

## WhiteNoise Core <br/> Differential Privacy Library Python Bindings <br/>

The python bindings are a sub-project of [Whitenoise-Core](https://github.com/opendifferentialprivacy/whitenoise-core).
See also the accompanying [WhiteNoise-System](https://github.com/opendifferentialprivacy/whitenoise-system) and [WhiteNoise-Samples](https://github.com/opendifferentialprivacy/whitenoise-samples) repositories for this system.

---

Differential privacy is the gold standard definition of privacy protection. The WhiteNoise project aims to connect theoretical solutions from the academic community with the practical lessons learned from real-world deployments, to make differential privacy broadly accessible to future deployments. Specifically, we provide several basic building blocks that can be used by people involved with sensitive data, with implementations based on vetted and mature differential privacy research. In WhiteNoise Core, we provide a pluggable open source library of differentially private algorithms and mechanisms for releasing privacy preserving queries and statistics, as well as APIs for defining an analysis and a validator for evaluating these analyses and composing the total privacy loss on a dataset.

This library provides an easy-to-use interface for building analyses.

Differentially private computations are specified as a protobuf analysis graph that can be validated and executed to produce differentially private releases of data.


- [More about WhiteNoise Core Python Bindings](#more-about-whitenoise-core-runtime)
  - [Component List](#components)
  - [Architecture](#architecture)
- [Installation](#installation)
  - [Binaries](#binaries)
  - [From Source](#from-source)
- [WhiteNoise Rust Documentation](#whitenoise-rust-documentation)
- [Communication](#communication)
- [Releases and Contributing](#releases-and-contributing)

---

## More about WhiteNoise Core Python Bindings

### Components

For a full listing of the extensive set of components available in the library [see this documentation.](https://opendifferentialprivacy.github.io/whitenoise-core/doc/whitenoise_validator/docs/components/index.html)

### Architecture

The Whitenoise-core system architecture [is described in the parent project](https://github.com/opendifferentialprivacy/whitenoise-core#Architecture).
This package is an instance of the language bindings. The purpose of the language bindings is to provide a straightforward programming interface to Python for building and releasing analyses.

Logic for determining if a component releases differentially private data, as well as the scaling of noise, property tracking, and accuracy estimates are handled by a native rust library called the Validator.
The actual execution of the components in the analysis is handled by a native Rust runtime.


## Installation

### Binaries

- (forthcoming PyPi binaries)

### From Source

1. Clone the repository

        git clone $REPOSITORY_URI --recurse-submodules

2. Install Whitenoise-core dependencies
   https://github.com/opendifferentialprivacy/whitenoise-core#installation

3. Generate code

        python3 scripts/code_generation.py

4. Install the python bindings

        pip install -e ".[test,plotting]"

    I recommend using `scripts/debug_*.sh` if you are developing the package.

---

### Documentation

[Documentation](https://opendifferentialprivacy.github.io/whitenoise-core/bindings-python/index.html).

## Communication

- Please use [GitHub issues](https://github.com/opendifferentialprivacy/whitenoise-core-python/issues) for bug reports, feature requests, install issues, and ideas.
- [Gitter](https://gitter.im/opendifferentialprivacy/WhiteNoise) is available for general chat and online discussions.
- For other requests, please contact us at [whitenoise@opendp.io](mailto:whitenoise@opendp.io).
  - _Note: We encourage you to use [GitHub issues](https://github.com/opendifferentialprivacy/whitenoise-core-python/issues), especially for bugs._

## Releases and Contributing

Please let us know if you encounter a bug by [creating an issue](https://github.com/opendifferentialprivacy/whitenoise-core-python/issues).

We appreciate all contributions. We welcome pull requests with bug-fixes without prior discussion.

If you plan to contribute new features, utility functions or extensions to the core, please first open an issue and discuss the feature with us.
  - Sending a pull request (PR) without discussion might end up resulting in a rejected PR, because we may be taking the core in a different direction than you might be aware of.

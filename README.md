# Tranim App Frontend (TAF)

## About The Project

Frontend part of softball pitch trajectories modeling and analysis application.

- Application URL: [tranim.cz](https://tranim.cz)
- Backend URL: [tranim.nede.cz/api](https://tranim.nede.cz/api)
- Backend API Documentation: [tranim.nede.cz/api/doc](https://tranim.nede.cz/api/doc)
- Backend Doxygen Documentation: [tranim.nede.cz/be/doc](https://tranim.nede.cz/be/doc)

## Installation

Clone the repository and install Bun dependencies.

```bash
git clone https://github.com/nedelamatej/taf.git && cd taf # clone the repository
bun install # install Bun dependencies
```

## Directory Structure

```bash
taf
├── node_modules                      # Bun dependencies
├── src                               # source code
│   ├── lib                           # SvelteKit utilities and components
│   │   ├── common                    # common components
│   │   ├── components                # reusable components
│   │   ├── js                        # JavaScript files
│   │   ├── shaders                   # GLSL shaders
│   │   │   ├── fragment.glsl         # field fragment shader
│   │   │   └── vertex.glsl           # field vertex shader
│   │   ├── Camera.svelte             # camera component
│   │   ├── Field.svelte              # field component
│   │   ├── Pitch.svelte              # pitch component
│   │   ├── Scene.svelte              # scene component
│   │   └── ...
│   ├── routes                        # SvelteKit routes
│   │   ├── events                    # events pages
│   │   ├── pitch                     # pitch page
│   │   ├── pitchers                  # pitchers pages
│   │   ├── +page.svelte              # home (organizations) page
│   │   └── ...
│   └── ...
├── static                            # static files
├── CHANGELOG.md                      # changelog
├── LICENSE.md                        # license
├── package.json                      # Bun configuration file
├── README.md                         # this file
└── ...
```

## Makefile Targets

```bash
make install                          # install Bun dependencies
make dev                              # start development server
make build                            # build production version
make check                            # run type checker
make format                           # run code formatter
make lint                             # run code linter
```

## Built With

[![Svelte][svelte]][svelte-url]\
[![JavaScript][javascript]][javascript-url]\
[![Tailwind_CSS][tailwindCss]][tailwindCss-url]\
[![Three.js][threeJs]][threeJs-url]\
[![Bun][bun]][bun-url]

## Conventions

All notable changes to this project are documented in [changelog](./CHANGELOG.md), the format is based on [Keep a Changelog](https://keepachangelog.com/).\
This project adheres to both [Conventional Commits](https://www.conventionalcommits.org/) and [Semantic Versioning](https://semver.org/).

## License

This project is licensed under the terms of the [MIT license](./LICENSE.md).

## Acknowledgments

This project is part of a bachelor's thesis:

- **Modelování a analýza trajektorií softballového nadhozu**
- University: Vysoké učení technické v Brně
- Faculty: Fakulta informačních technologií
- Department: Ústav počítačové grafiky a multimédií
- Author: Matěj Neděla ([nedela.matej@gmail.com](mailto:nedela.matej@gmail.com))
- Supervisor: Ing. Tomáš Milet, Ph.D. ([imilet@fit.vut.cz](mailto:imilet@fit.vut.cz))

## Contact

[![Name][name]][name-url]\
[![Email][email]][email-url]\
[![GitHub][github]][github-url]

[svelte]: https://img.shields.io/badge/svelte-FF3E00?style=for-the-badge&logo=svelte&logoColor=white
[svelte-url]: https://svelte.dev/
[javascript]: https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black
[javascript-url]: https://developer.mozilla.org/javascript/
[tailwindCss]: https://img.shields.io/badge/tailwind_css-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white
[tailwindCss-url]: https://tailwindcss.com/
[threeJs]: https://img.shields.io/badge/three.js-000000?style=for-the-badge&logo=threedotjs&logoColor=white
[threeJs-url]: https://threejs.org/
[bun]: https://img.shields.io/badge/bun-000000?style=for-the-badge&logo=bun&logoColor=white
[bun-url]: https://bun.sh/
[name]: https://img.shields.io/badge/Matěj_Neděla-241F31?style=for-the-badge&logo=gnometerminal&logoColor=white
[name-url]: https://nede.cz/
[email]: https://img.shields.io/badge/nedela@nede.cz-EA4335?style=for-the-badge&logo=gmail&logoColor=white
[email-url]: mailto:nedela@nede.cz
[github]: https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white
[github-url]: https://github.com/nedelamatej/

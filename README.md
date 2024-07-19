# Services Flake LLM

A [Nix flake] to locally spawn the following services:
 - [Ollama]
 - [Tika]
 - [Searxng]
 - [Open-WebUI]

The services are spawned using [`process-compose`].

The data are kept in the current directory you run the command.

To run it:

```shell
nix run github:drupol/wip-services-flake-llm
```

The services will be available at the following addresses:
 - Ollama: http://localhost:11434
 - Tika: http://localhost:9998
 - Searxng: http://localhost:8080
 - Open-WebUI: http://localhost:1111

[`process-compose`]: https://github.com/F1bonacc1/process-compose
[Ollama]: https://github.com/ollama/ollama
[Tika]: https://tika.apache.org/
[Searxng]: https://github.com/searxng/searxng
[Open-WebUI]: https://github.com/open-webui/open-webui
[Nix flake]: https://wiki.nixos.org/wiki/Flakes

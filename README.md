# Services Flake LLM

Provides a local environment for running several AI-related and document-processing services, including:

- [Open-WebUI] — chat interface for local models
- [Ollama] — local LLM inference
- [Tika] — document text extraction
- [Searxng] — privacy-respecting metasearch engine

All services are orchestrated via [`process-compose`], **no containers are used**.
Service data and configuration are stored in the directory from which you run the command.

## Usage

1. **Find the latest release**
   Visit the [tags page] to get the most recent version tag.

2. **Run the flake**
   Replace `<latest>` with the version tag you found (for example, `0.2.0`):

   ```bash
   nix run github:drupol/wip-services-flake-llm/<latest>
   ```

3. **Access the services**

   | Service       | URL                                                                               |
   | ------------- | --------------------------------------------------------------------------------- |
   | Open-WebUI    | [http://localhost:1111](http://localhost:1111)                                    |
   | Ollama        | [http://localhost:11434](http://localhost:11434)                                  |
   | Tika          | [http://localhost:9998](http://localhost:9998)                                    |
   | Searxng       | [http://localhost:8080](http://localhost:8080)                                    |

---

## Notes

- All processes are managed by [`process-compose`], which provides a unified dashboard for logs and process control.
- Because no containers are involved, the services start quickly and integrate directly with your local environment.
- Each service stores its runtime data in the current working directory, so you can easily inspect or remove it.

[`process-compose`]: https://github.com/F1bonacc1/process-compose
[Ollama]: https://github.com/ollama/ollama
[Tika]: https://tika.apache.org/
[Searxng]: https://github.com/searxng/searxng
[Open-WebUI]: https://github.com/open-webui/open-webui
[Nix flake]: https://wiki.nixos.org/wiki/Flakes
[tags page]: https://github.com/drupol/wip-services-flake-llm/tags

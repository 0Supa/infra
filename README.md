# ❄️ Infra

Supa's multi-system flake

<sub>Screenshot of [Kappa](hosts/nixos/Kappa) as of 11-01-2026</sub>
![](https://github.com/user-attachments/assets/11ebf1c9-b96f-4a4f-8c0e-de97c5b7ad07)

# 📦 Structure

- 🖼️ [/assets](assets) `shared resources`
- 🧩 [/common](common) `reusable modules`
- 🖥️ [/hosts](hosts) `host-specific setups`
  - ❄️ [/nixos](hosts/nixos) `NixOS systems`
    - 👩🏻‍💻 **[/Kappa](hosts/nixos/Kappa) `desktop`**
      - 🏠 [/home](hosts/nixos/Kappa/home) `app settings`
    - 🌐 **[/Kappacino](hosts/nixos/Kappacino) `homeserver`**
      - ⚙️ [/etc](hosts/nixos/Kappacino/etc) `system overrides`
      - 🛠️ [/services](hosts/nixos/Kappacino/services) `service definitions`
        - 🔧 [/systemd](hosts/nixos/Kappacino/services/systemd) `standalone services`
        - ...

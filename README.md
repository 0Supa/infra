# ❄️ Infra

Supa's multi-system flake

<sub>Screenshot of [Kappa](hosts/nixos/Kappa) as of 18-08-2025</sub>
![](https://github.com/user-attachments/assets/b8119586-3d43-41df-ae88-451c9bb7b40d)

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

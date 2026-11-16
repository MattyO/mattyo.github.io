---
layout: default
title: Home Lab
---

<main>

  <p>
    My home lab setup — where I tinker with servers, networks, and software projects.
  </p>

  <section class="lab-section">
    <h2>Highlights</h2>
    <ul class="lab-list">
      <li><strong>Fully automated setup and configuration</strong> — reproducible infrastructure via <a href="https://github.com/MattyO/self-hosted">Terraform and Ansible</a></li>
      <li><strong>Real-time observability</strong> — Prometheus and Loki with logs from network devices and sFlow traffic analytics</li>
      <li><strong>Segregated hosts via VLANs</strong> — Network isolation across dedicated VLANs for home, work, AI, and server workloads</li>
    </ul>
  </section>

  <div class="svg-pan-container" style="height: 500px;">
    <object id="network-diagram" data="/assets/images/network-overview.drawio.svg" type="image/svg+xml" class="network-svg-object"></object>
    <span class="pan-hint">drag to pan &middot; scroll to zoom</span>
  </div>

  <section class="lab-section">
    <h2>Hardware</h2>
    <div class="lab-card-grid">
      <div class="lab-card">
        <h3>Refurbished Dell Blade Server</h3>
        <div class="lab-tags">
          <span class="tag">server</span>
        </div>
        <p class="lab-description">
          3 TB RAID 5 storage, 125 GB RAM, CPU — enough for now
        </p>
      </div>

      <div class="lab-card">
        <h3>Fortinet F40</h3>
        <div class="lab-tags">
          <span class="tag">firewall</span>
          <span class="tag">fortinet</span>
        </div>
        <p class="lab-description">
          Firewall — network segmentation, firewall policy, dhcp and ipsec tunneling.
        </p>
      </div>

      <div class="lab-card">
        <h3>Cisco C1300</h3>
        <div class="lab-tags">
          <span class="tag">switch</span>
          <span class="tag">cisco</span>
          <span class="tag">L2/L3</span>
        </div>
        <p class="lab-description">
          Managed switch — VLAN segmentation and sFlow traffic analytics.
        </p>
      </div>

      <div class="lab-card">
        <h3>FS AP</h3>
        <div class="lab-tags">
          <span class="tag">wifi</span>
        </div>
        <p class="lab-description">
          Wireless access point — VLAN-aware. provides multiple wans that further segregate connected devices to their correct vlans.
        </p>
      </div>
    </div>
  </section>

  <section class="lab-section">
    <h2>Orchestration, Automation &amp; Containers</h2>
    <p>
      <strong>Ansible</strong> configures all network infrastructure across the FortiGate firewall, Cisco switch, and blade server.
      Containers are run through <strong>Incus</strong>, which pools memory, CPU, and disk space across containers.
      Containers can be deployed into any VLAN available on the network.
      <strong>Terraform</strong> manages container creation, and <strong>Ansible</strong> handles their ongoing configuration and management.
    </p>
  </section>

  <section class="lab-section">
    <h2>Monitoring &amp; Observability</h2>
    <p>
      <strong>Grafana</strong>, <strong>Prometheus</strong>, and <strong>Loki</strong> form the backbone of the lab's observability.
      Logs from hosts, the switch, and firewall are shipped to Loki, while Prometheus collects host and service metrics.
      Grafana provides unified dashboards using data sources from both Loki and Prometheus, offering a single location to monitor system status.
      sFlow network telemetry is collected by a <strong>GoFlow2</strong> collector and forwarded into Loki for long-term log correlation.
    </p>

    <div class="monitoring-gallery">
      <div class="monitoring-img-wrapper">
        <img id="ai-monitoring" src="/assets/images/ai-monitoring.png" alt="AI monitoring dashboard" class="monitoring-img">
        <p class="monitoring-caption">AI Metrics Overview</p>
      </div>

      <div class="monitoring-img-wrapper">
        <img id="grafana-network-traffic" src="/assets/images/grafana-network-traffic.png" alt="Grafana network traffic" class="monitoring-img">
        <p class="monitoring-caption">Network Traffic Overview</p>
      </div>

      <div class="monitoring-img-wrapper">
        <img id="host-overview" src="/assets/images/host-overview.png" alt="Host overview" class="monitoring-img">
        <p class="monitoring-caption">Host Status &amp; Inventory</p>
      </div>
    </div>
  </section>

  <div class="back-link">
    <a href="/projects.html">← Back to Projects</a>
  </div>

</main>

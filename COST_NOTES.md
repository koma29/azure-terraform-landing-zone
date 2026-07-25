# Cost Notes & Tagging Strategy

## Estimated Monthly Cost

This landing zone is designed to run at effectively **$0/month** under Azure's free
allowances. Breakdown of the deployed resources:

| Resource | Billing Model | Estimated Cost |
|---|---|---|
| Resource Group | Container only, not billable | $0.00 |
| Virtual Network | No charge for the VNet itself | $0.00 |
| Subnet | No charge | $0.00 |
| Network Security Group + rules | No charge | $0.00 |
| Log Analytics Workspace | Pay-as-you-go after 5 GB/month free tier | $0.00 at low ingest |

**Total: ~$0.00/month** at current scale.

## What Would Actually Cost Money

Understanding *what bills* in an Azure network is as important as understanding what
doesn't. The Azure networking resources deployed here are free, but these adjacent
resources are not:

- **Public IP addresses** — Standard SKU public IPs bill hourly whether or not they
  are attached to anything. Orphaned public IPs left behind after a VM or load
  balancer is deleted are one of the most common sources of unexplained Azure spend.
- **VNet peering** — free to configure; charges apply to **data transferred** across
  the peering connection (inbound and outbound, per GB).
- **VPN Gateway / Azure Firewall / NAT Gateway** — these bill hourly plus data
  processing, and are the expensive components of most real landing zones.
- **Log Analytics ingestion beyond 5 GB/month** — diagnostic settings that forward
  verbose logs from many resources can quietly exceed the free tier.
- **Virtual machines and managed disks** — the primary compute cost in most
  environments.

## Cost Governance Approach

If this landing zone were extended toward production use, the cost controls I would
add are:

1. **Resource tagging policy** — enforce `Environment`, `Owner`, `CostCenter`, and
   `Project` tags on every resource via Azure Policy, so Cost Management can slice
   spend by owner and workload rather than showing one undifferentiated bill.

2. **Budgets and alerts** — set an Azure Budget at the subscription or resource group
   scope with alert thresholds (for example, 50% / 80% / 100% of forecast) routed to
   an action group.

3. **Cost Management exports** — schedule a daily cost export to a storage account so
   spend data can be analyzed historically rather than only in the portal UI.

4. **Meter-level cost analysis** — when an unexpected charge appears, group cost by
   *meter* rather than by resource. Meters are the actual billing units, and a charge
   that appears under a "Virtual Network" line item is frequently an attached public
   IP or gateway rather than the VNet itself.

5. **Log Analytics retention and ingestion caps** — set a daily ingestion cap on the
   workspace and tune diagnostic settings so only useful log categories are forwarded.

## Current Tagging

Tags applied to the resources in this deployment:

```hcl
tags = {
  Environment = "dev"
  Project     = "azure-landing-zone"
  ManagedBy   = "terraform"
}
```

Tagging every resource from the start is significantly easier than retrofitting tags
onto an environment that already has hundreds of untagged resources.

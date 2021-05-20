## Install with Helm Chart: 

- [Create Private CA:](https://www.notion.so/Kubernetes-cert-manager-8e346053ee894d2cbe33b934a809c240)
- Vault Operator Init - Raft Setup
## Links:
        - [Vault HA with Raft - examples](https://www.vaultproject.io/docs/platform/k8s/helm/examples/ha-with-raft)
        - [Vault HA with Raft](https://www.vaultproject.io/docs/platform/k8s/helm/examples/ha-with-raft)

## Reference Links:
        - https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
        - https://www.vaultproject.io/docs/configuration/storage/raft
        - https://learn.hashicorp.com/tutorials/vault/raft-ha-storage?in=vault/raft
        - https://learn.hashicorp.com/tutorials/vault/ha-with-consul
        - https://www.youtube.com/watch?v=Eapf-OWbKH8&ab_channel=ThatDevOpsGuy


## Initialize and unseal vault-0 pod:

```
        NS=vault-odp
        POD0=vault-odp-0
        kubectl exec -it -n $NS $POD0 -c vault "--" sh -c "vault operator init -key-shares=5 -key-threshold=3"
        Recovery Key 1: WB7cT/MbhPTigA/T6vetoA5JWIZNz5W5KjDRcOe+zVp1
        Recovery Key 2: YPZubGqXX3hn0pU431MDfdwWDllgQCA2W0ueIbL+ZZdi
        Recovery Key 3: sSUOMGekbXWodoENT76OoKAT3fruF4ww4Pj53rjBeBXK
        Recovery Key 4: G9OQADLlxZSdfOISKmFSpCZZ6yQYl2yKjWVeGWv+vLOc
        Recovery Key 5: iMpk1tqkh7cgHC2rT+GIHUd573Zg48v2S4fx+HvMOIaC

        Initial Root Token: s.F4it3bb4zAtKfJsmTyDx4BNG

        Success! Vault is initialized

        Recovery key initialized with 5 key shares and a key threshold of 3. Please
        securely distribute the key shares printed above.
```

    - Unseal all other nodes and join the raft

        Link: [Ha with Raft](https://www.vaultproject.io/docs/platform/k8s/helm/examples/ha-with-raft): 

```
        CMD="vault operator unseal"
        kubectl exec -it -n  vault-odp vault-odp-0 -c vault "--" sh -c ${CMD}
```

    - List Peers:

```bash
        vault operator raft list-peers
```

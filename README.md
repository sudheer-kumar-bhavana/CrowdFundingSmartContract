# CrowdFundingSmartContract

#### This is a simple crowd funding smart contract.
Following parameters need to be passed to contract while deploying.

```
_targetAmount -> Total amount to be raised
_minBuy -> minimum amount that can be funded by a participant
_maxBuy -> maximum amount that can be funded by a participant
_endOn  -> number of days target amount should be raised from the day contract deployed

```

###### call fund function and pass the amount in wei.

###### call getAmountRaisedSofar to know how much amount has been raised so far.

###### call refund to get the amount back incase target amount is not reached within the period set.

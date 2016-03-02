# cash_machine

Programming test for [this task](https://jinshuju.net/f/n0ddSe)

Discuss is [here](https://ruby-china.org/topics/29168)

## useage

#### 1. no discount
```ruby
require './cash_machine'

items = [
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000003-2',
    'ITEM000005',
    'ITEM000005',
    'ITEM000005'
]

CashMachine.perform(items)
```
result:
```shell
***<没钱赚商店>购物清单***
名称：羽毛球，数量：5个，单价：1.0(元)，小计：5.0(元)
名称：苹果，数量：2斤，单价：5.5(元)，小计：11.0(元)
名称：可口可乐，数量：3瓶，单价：3.0(元)，小计：9.0(元)
----------------------
总计：25.0(元)
**********************
```

#### 2. with buy two free one discount
```ruby

CashMachine::DiscountTable.refresh!({
  free_one: ['ITEM000001', 'ITEM000005']
})
CashMachine.perform(items)
```
result:

``` shell
***<没钱赚商店>购物清单***
名称：羽毛球，数量：5个，单价：1.0(元)，小计：4.0(元)
名称：苹果，数量：2斤，单价：5.5(元)，小计：11.0(元)
名称：可口可乐，数量：3瓶，单价：3.0(元)，小计：6.0(元)
----------------------
买二赠一商品：
名称：羽毛球，数量：1个
名称：可口可乐，数量：1瓶
----------------------
总计：21.0(元)
节省：4.0(元)
**********************
```

#### 3. with nine_five_discount
```ruby
CashMachine::DiscountTable.refresh!({
  nine_five_discount: ['ITEM000003']
})
CashMachine.perform(items)
```

result:

```shell
***<没钱赚商店>购物清单***
名称：羽毛球，数量：5个，单价：1.0(元)，小计：5.0(元)
名称：苹果，数量：2斤，单价：5.5(元)，小计：10.45(元)，节省0.55(元)
名称：可口可乐，数量：3瓶，单价：3.0(元)，小计：9.0(元)
----------------------
总计：24.45(元)
节省：0.55(元)
**********************
```

#### 4. with both free_one and nine_five_discount
```ruby
items = [
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000001',
    'ITEM000003-2',
    'ITEM000005',
    'ITEM000005',
    'ITEM000005'
]
CashMachine::DiscountTable.refresh!({
  free_one: ['ITEM000001', 'ITEM000005'],
  nine_five_discount: ['ITEM000003']
})
CashMachine.perform(items)
```

result:

```shell
***<没钱赚商店>购物清单***
名称：羽毛球，数量：6个，单价：1.0(元)，小计：4.0(元)
名称：苹果，数量：2斤，单价：5.5(元)，小计：10.45(元)，节省0.55(元)
名称：可口可乐，数量：3瓶，单价：3.0(元)，小计：6.0(元)
----------------------
买二赠一商品：
名称：羽毛球，数量：2个
名称：可口可乐，数量：1瓶
----------------------
总计：20.45(元)
节省：5.55(元)
**********************
```

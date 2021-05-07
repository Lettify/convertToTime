# convertToTime (Lua useful function for Multi Theft Auto)
Este código tem como objetivo fazer conversões de tempo facilmente.
### Sintaxe válida:
```lua
int/float string convertToTime ( float num, string convertion )
```
> #### Argumentos necessários:
> - **num**: número para ser convertido.
> - **convertion**: string determinando como o número **num** será convertido.
>
> #### Retorno
> Retorna dois valores, um **int/float** do número convertido e uma **string** do número convertido e sua unidade de tempo.

### Exemplo:
```lua
print('7 dias para hora', convertToTime(7, 'dias>horas'))
-- output: 7 dias para hora	168	168 horas
print('1 semana para horas', convertToTime(1, 'semana>hora'))
-- output: 1 semana para horas	168	168 horas
```
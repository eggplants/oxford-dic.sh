# oxford-dic.sh

- Oxford Dictionaries API in Bash

## Prepare

0. Install [curl/curl](https://github.com/curl/curl), [stedolan/jq](https://github.com/stedolan/jq)
1. [Register](https://developer.oxforddictionaries.com/signup?plan_ids[]=2357355970463)
2. [Get Credentials](https://developer.oxforddictionaries.com/credentials)
3. `mkdir -p ~/.config`
4. Edit `~/.config/oxdic`

```bash
app_id='...'
app_key='...'
```

## References

- [Oxford Dictionaries API Documentation](https://developer.oxforddictionaries.com/documentation)
- [Supported Languages](https://developer.oxforddictionaries.com/documentation/languages)
- [tobiohlala/describe](https://github.com/tobiohlala/describe)

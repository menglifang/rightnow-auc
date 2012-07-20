## 描述

`rightnow-auc`将提供一个统一的用户身份认证服务，并提供多应用的单点登录（SSO）。其基于[devise](https://github.com/plataformatec/devise) 和[doorkeeper](https://github.com/applicake/doorkeeper) 进行开发。

*申明* 目前`rightnow-auc`还处于早期开发阶段。

### OmniAuth Strategy

```ruby
# lib/omniauth/strategies/rightnow_auc.rb
module OmniAuth
  module Strategies
    class RightnowAuc < OmniAuth::Strategies::OAuth2
      option :name, :rightnow_auc

      option :client_options, {
        :site => "http://your.rightnow-auc.app",
        :authorize_path => "/oauth/authorize"
      }

      uid do
        raw_info["id"]
      end

      info do
        {
          :email => raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/me.json').parsed
      end
    end
  end
end
```

### 在线演示

测试地址：[http://rightnow-auc.herokuapp.com](http://rightnow-auc.herokuapp.com)

```
+-------------------+----------+--------+
| User Name         | Password | Admin? |
+-------------------+----------+--------+
| admin@example.org | 123456   | Y      |
+-------------------+----------+--------+
| user@example.org  | 123456   | N      |
+-------------------+----------+--------+
```

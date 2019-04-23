## 多个id shop_admin_id_eq_any

```
  <label class="col-md-1 control-label"><%= local_assigns.fetch :label_name, "收银员"%></label>
  <div class="col-md-5 select2_box">
    <%= f.select :shop_admin_id_eq_any,
                 options_for_select(options_for_cashiers(current_admin), @q.shop_admin_id_eq_any),
                 {},
                 { class: 'form-control select2', multiple: true }
    %>
```
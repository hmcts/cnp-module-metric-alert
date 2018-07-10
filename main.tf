
data "template_file" "metricalerttemplate" {
  template = "${file("${path.module}/templates/Alert.json")}"
}

resource "azurerm_template_deployment" {
  template_body       = "${data.template_file.metricalerttemplate.rendered}"

  name = "Create custom alert template"
  deployment_mode = "Incremental"

  resource_group_name = "${parameters("resourceGroupName")}"
}

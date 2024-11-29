defmodule CodomariBackend.Renderers.PageHTML do
  use CodomariBackend, :html

  embed_templates "page_html/*"
end

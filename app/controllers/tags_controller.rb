class TagsController < ApplicationController
  autocomplete :tag, :name
end

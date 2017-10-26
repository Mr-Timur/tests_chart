# Installation

Here you have steps to get the
application up and running:

* git clone git@github.com:Mr-Timur/tests_chart.git

* Go to the project folder

* gem install bundler (If you use RVM or something similar)

* bundle install

* rake db:create

* rake db:migrate

* rake db:seed (Needed to fill DB from CSV file)

* rails server
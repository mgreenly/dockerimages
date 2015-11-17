FROM mgreenly/ruby

#
# Create the user account that will run the ruby application.
#
RUN useradd -ms /bin/bash utopia

#
# Do everything as that user
#
USER utopia

#
# This user doesn't have access to write gems int /usr/local/gems so
# use a folder in the user's home directory.  Also add that to the
# path so gems with executables work.
#
ENV GEM_HOME /home/utopia/.gems
ENV PATH /home/utopia/.gems/bin:/usr/local/bin:/usr/bin:/bin

#
# Copy the application into the image
#
RUN mkdir -p /home/utopia/lifeline
COPY ./lib /home/utopia/lifeline/
COPY ./bin /home/utopia/lifeline/
COPY Gemfile*  /home/utopia/lifeline/

#
# Install the gems needed by the image
#
WORKDIR /home/utopia/lifeline
RUN bundle



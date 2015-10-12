class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split.length

    @occurrences = @text.upcase.split.count(@special_word.upcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_rate = @apr / 12 / 100
    total_months = @years * 12
    @monthly_payment = monthly_rate * @principal / (1 - (1 + monthly_rate) ** -total_months)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    number_median_1 = @sorted_numbers[(@sorted_numbers.length - 1) / 2]

    number_median_2 = @sorted_numbers[@sorted_numbers.length / 2]

    @median = (number_median_1 + number_median_2) / 2

    @sum = @numbers.inject{ |sum, value| sum + value } # Can use @numbers.inject(:+) with Ruby +1.8.7
    #Documentation for inject (http://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-inject)

    @mean = @sum / @count

    @variance = @numbers.inject(0){ |sum_values, i| sum_values + (i - @mean) ** 2 } / @count
    # inject(0) because the first value of sum_values need to be 0 (and not the first element of @numbers)

    @standard_deviation = @variance ** 0.5

    #MODE
    #First we create an Hash from the Array using inject, mapping each value of the array to its frequency
    numbers_hash = @numbers.inject(Hash.new(0)) { |hash, specific_number| hash[specific_number] += 1; hash}

    #Than we look at the maximum frequency (http://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-max_by)
    @mode = @numbers.max_by { |valeur| numbers_hash[valeur] }


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

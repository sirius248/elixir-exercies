defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({pos_integer, pos_integer, pos_integer}) :: :calendar.date

	# 365 * 24 * 60 * 60
	@gigasecond 1_000_000_000

	def from({year, month, day}) do
		{{year, month, day}, {0,0,0}} |> :calendar.datetime_to_gregorian_seconds
																	|> plus_gigasecond
																	|> :calendar.gregorian_seconds_to_datetime
																	|> elem(0)
	end

	defp plus_gigasecond(seconds) do
		seconds + @gigasecond
	end
end

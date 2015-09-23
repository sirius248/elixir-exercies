defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @earth_year 31557600
  @mecury_year 7600543.81992
  @venus_year 19414149.052176
  @mars_year 59354032.690079994
  @jupiter_year 374355659.124
  @saturn_year 929292362.8848
  @neptune_year 5200418560.032001
  @uranus_year 2651370019.3296

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    case planet do
      :earth   -> seconds / @earth_year
      :mercury -> seconds / @mecury_year
      :venus   -> seconds / @venus_year
      :mars    -> seconds / @mars_year
      :jupiter -> seconds / @jupiter_year
      :saturn  -> seconds / @saturn_year
      :neptune -> seconds / @neptune_year
      :uranus  -> seconds / @uranus_year
    end
  end
end

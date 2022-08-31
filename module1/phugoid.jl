#========================================#
# Name: Arturo Burgos                    #
# Course: Numerical Aero/Hidrodynamics   #
#                                        #
#          Phugoid Trajectory            #
#                                        #
#========================================#

# Second order ODE: Harmonic Oscillation.

# Creating time grid: 

T = 100 # Length of the time-interval
dt = 0.02 # Time-step size
n = Int(T / dt) + 1 # Number of time-steps. +1 is because we want our initial condition to be also computed
t = range(0.0, T, n)


# Set initial conditions:

z0 = 100.0 # Altitude
b0 = 10.0 # Upward velocity resulting from gust ("rajada")
zt = 100.0 # Trim altitude
g = 9.81 # Acceleration due to gravity


# Set the initial value of the numerical solution: 
u = [z0 b0]


# Create an array to store the elevation value at each time-step:

z = zeros(n)
z[1] = z0

 
# Temporal Integration using Euler's Method:

for i in 2:n # Option 1
    rhs = [u[2], g * (1 - u[1] / zt)]
    u[:] = u[:] + dt * rhs
    z[i] = u[1]
end

#= for i in 2:n # Option 2
    u[1] = u[1] + dt * u[2]
    u[2] = u[2] + dt * (g * (1 - u[1] / zt))
    z[i] = u[1]
end =#



using Plots, LaTeXStrings, Measures # Possible to use PyPlot too.
gr()

#= plot_font = "Computer Modern"
default(fontfamily = plot_font,
        linewidth = 2, framestyle = :box, label = nothing, grid = true, gridlinewidth = 1, gridalpha = 0.1, minorgrid = true)
# NOTE: using the recipe we verify that we use a lot of more attributes
plot(t,z) =#

@userplot phugoid
@recipe function f(var::phugoid)
        
    size --> (950,400)
    margin --> 5mm
    top_margin --> 3mm
    framestyle --> :box
    grid --> :true
    gridalpha --> 5
    gridwidth --> 0.3
    minorgrid --> :true
    minorgridalpha --> 1
    minorgridwidth --> 0.05
    fontfamily --> "Computer Modern"

    t, z = var.args
    title --> "Elevation of the phugoid over time"
    legend --> :topright
    label --> "phugoid"
    xaxis --> ("Time [s]", (t[1],t[end]))
    yaxis -->("Elevation [m]", (40.0, 160.0))
    #yguidefontrotation --> -90
    seriestype --> :line 
    linewidth --> 1.5
    color --> :red
    
    return t, z
    
end

#= root = dirname(@__FILE__)
root = joinpath(root, "images/") =# # Below a more simplified way to define that (PATH1):

# Examples of PATH's

PATH1 = joinpath(dirname(@__FILE__), "images/")
PATH2 = dirname(@__DIR__)
PATH3 = "/"*relpath((@__FILE__)*"/..","/") # Apparently more suitable for Linux Environment
PATH4 = "/"*relpath((@__FILE__)*"/","/") # Apparently more suitable for Linux Environment
PATH5 = "/"*relpath((@__FILE__)*"/../images","/") # Apparently more suitable for Linux Environment
PATH6 = relpath(@__FILE__)
PATH7 = dirname(@__FILE__)
PATH8 = "/"*relpath((@__FILE__)*"/../..","/") # Apparently more suitable for Linux Environment

println("The PATH1 is:")
println(PATH1)
println("\n")

println("The PATH2 is:")
println(PATH2)
println("\n")

println("The PATH3 is:")
println(PATH3)
println("\n")

println("The PATH4 is:")
println(PATH4)
println("\n")

println("The PATH5 is:")
println(PATH5)
println("\n")

println("The PATH6 is:")
println(PATH6)
println("\n")

println("The PATH7 is:")
println(PATH7)
println("\n")

println("The PATH8 is:")
println(PATH8)

# Using PATH1:

plot = phugoid(t,z)
display(plot)

savefig(phugoid(t,z), "$PATH1/phugoid.png")



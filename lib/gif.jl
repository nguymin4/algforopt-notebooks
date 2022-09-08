import Plots as plt

function plot_animation(plot_fn, plot_frame_args_list::Vector; size=(600, 600), fps=1.5)
  animation = plt.Animation()
  for plot_arg in plot_frame_args_list
    plot = plot_fn(plot_arg; size=size)
    plt.frame(animation, plot)
  end
  plt.gif(animation, fps=fps)
end
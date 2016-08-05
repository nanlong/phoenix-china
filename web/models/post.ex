defmodule PhoenixChina.Post do
  use PhoenixChina.Web, :model

  alias PhoenixChina.Repo
  alias PhoenixChina.Comment

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :user, PhoenixChina.User
    has_many :comments, Comment, on_delete: :delete_all

    # 评论数量
    field :comment_count, :integer, default: 0
    # 收藏数量
    field :collect_count, :integer, default: 0
    # 点赞数量
    field :praise_count, :integer, default: 0
    # 最新一个评论
    belongs_to :latest_comment, PhoenixChina.Comment, foreign_key: :latest_comment_id

    timestamps()
  end

  @required_params [:title, :content, :user_id]
  @optional_params [:comment_count, :collect_count, :praise_count, :latest_comment_id]


  def changeset(action, struct, params \\ %{})

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(:insert, struct, params) do
    struct
    |> cast(params, @required_params, @optional_params)
    |> validate_required(@required_params)
    |> validate_length(:title, min: 1, max: 140)
    |> validate_length(:content, min: 1, max: 20000)
  end

  def changeset(:update, struct, params) do
    struct
    |> cast(params, @required_params, @optional_params)
    |> validate_required(@required_params)
    |> validate_length(:title, min: 1, max: 140)
    |> validate_length(:content, min: 1, max: 20000)
  end

  def set(%{:id => post_id}, :latest_comment_id, value) do
    __MODULE__
    |> where(id: ^post_id)
    |> update(set: [latest_comment_id: ^value])
    |> Repo.update_all([])
  end

  defp inc_or_dec(query, action, field, step \\ 1) do
    value = case action do
      :inc -> step
      :dec -> -step
    end

    opts = case field do
      :comment_count ->
        [{:comment_count, value}]
      :collect_count ->
        [{:collect_count, value}]
      :praise_count ->
        [{:praise_count, value}]
    end

    query
    |> update(inc: ^opts)
    |> Repo.update_all([])
  end

  def inc(%{:id => post_id}, field) do
    __MODULE__
    |> where(id: ^post_id)
    |> inc_or_dec(:inc, field)
  end

  def dec(%{:id => post_id}, field) do
    __MODULE__
    |> where(id: ^post_id)
    |> inc_or_dec(:dec, field)
  end

end

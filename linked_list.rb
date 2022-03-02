require "pry-byebug"

class Node
  attr_accessor :value, :next_node

   def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
   end
end

class LinkedList < Node

  def initialize
    @head = Node.new
  end

  def prepend(value)
    new_node = Node.new(value)

    if @head.value == nil
      @head = new_node
    else
      temp = @head
      @head = new_node
      @head.next_node = temp
    end
  end

  def append(value)
    new_node = Node.new(value)
    control = @head

    if @head.next_node == nil
      @head.next_node = new_node
    else 
      until control.next_node == nil
        control = control.next_node
      end
      control.next_node = new_node
    end
  end

  def size
    total = 1
    control = @head

    until control.next_node == nil
      total += 1
      control = control.next_node
    end
    total
  end

  def head
    @head.value
  end

  def tail
    control = @head

    until control.next_node == nil
      control = control.next_node
    end

    control.value
  end

  def at(index)
    total = 0
    control = @head

    until total == index
      control = control.next_node
      total += 1
    end

    control.value
  end

  def pop
    control = @head
    previous_node = nil

    until control.next_node == nil
      previous_node = control
      control = control.next_node
    end
    previous_node.next_node = nil
  end

  def contains?(value)
    control = @head
    bool = false

    until control == nil
      if control.value == value
        bool = true
        break
      end
      bool = control.value == value
      control = control.next_node
    end
    bool
  end

  def find(value)
    control = @head
    index = 0

    until control.value == value
      index += 1
      control = control.next_node
      if control == nil
        break
      end
    end

    if control == nil
      "The value was not in the list"
    else
      index
    end   
  end
    
  def to_s
    control = @head
    output = ""

    until control == nil
      output << "(#{control.value}) -> "
      control = control.next_node
    end
    output.chomp(' -> ')
  end

  def insert_at(index, value)
    control = @head
    count = 0
    
    if index == 0 
      new_node = Node.new(value, @head)
      @head = new_node
    elsif index > (self.size)
      "nil"
    else
      until count == (index-1) 
        count += 1
        control = control.next_node
      end

      new_node = Node.new(value, control.next_node)
      control.next_node = new_node
    end
  end

  def remove_at(index)
    count = 0
    control = @head
    previous_node = @head

    if index > self.size - 1
      "Index given is greater than list size"
    else
      if index == 0
        @head = @head.next_node
      else
        until count == index
          previous_node = control
          count += 1
          control = control.next_node
        end
        previous_node.next_node = control.next_node
      end
    end
  end

end

cars = LinkedList.new
cars.prepend("Audi")
cars.prepend("Tesla")
cars.prepend("Mercedes")
cars.append("Dodge")
cars.append("Volkswagon")

puts "This is the initial linked list #{cars.to_s}"
puts "\nThis is the first node: #{cars.head}"
puts "\nThis is the last node: #{cars.tail}"
puts "\nThe size of the dataset is: #{cars.size}"
puts "\nThe value at index 2 in the linked list is: #{cars.at(2)}"
puts "\nDoes the list contain 'Dodge'?: #{cars.contains?("Dodge")}"
puts "\nDoes the list contain 'Nissan'?: #{cars.contains?("Nissan")}"
puts "\nThe value 'Dodge' is at index: #{cars.find("Dodge")}"
puts "\nThis is what is returned when the value is not in the list: #{cars.find("Honda")}"

cars.pop
puts "\ncars.pop removes the last value: #{cars.to_s}"

cars.insert_at(2, "Ford")
puts "\ncars.insert_at(2, \"Ford\") should insert 'Ford' at position 2: #{cars.to_s}"

puts "\nThis is what is returned if you try to insert a value at an index greater than the list size: #{cars.insert_at(6, "Vauxhall")}"

cars.remove_at(3)
puts "\ncars.remove(3) should remove 'Audi': #{cars.to_s}"

cars.remove_at(0)
puts "\n cars.remove(0) removes the first value: #{cars.to_s}"

